#!/usr/bin/env /Users/cv/.gemini/kokoro-venv/bin/python3
import os
import sys
import re
from pathlib import Path

# Ground environment for MLX, espeak-ng loader, and venv
GEMINI_DIR = Path.home() / ".gemini"
VENV_DIR = GEMINI_DIR / "kokoro-venv"
os.environ["VIRTUAL_ENV"] = str(VENV_DIR)
os.environ["PATH"] = f"{VENV_DIR / 'bin'}:{os.environ.get('PATH', '')}"

site_packages = list(VENV_DIR.glob("lib/python*/site-packages"))[0]
os.environ["ESPEAK_DATA_PATH"] = str(site_packages / "espeakng_loader")

import json
import time
import socket
import signal
import threading
import subprocess

from kokoro_mlx import KokoroTTS
import soundfile as sf

SOCKET_PATH = GEMINI_DIR / "kokoro.sock"
PID_FILE = GEMINI_DIR / "kokoro.pid"
CONFIG_PATH = GEMINI_DIR / "voice_config.json"
MODE_PATH = GEMINI_DIR / "voice_mode"
AUDIO_DIR = GEMINI_DIR / "tmp" / "audio"
AUDIO_DIR.mkdir(parents=True, exist_ok=True)

class KokoroDaemon:
    def __init__(self):
        self.tts = None
        self.config = {}
        self.config_mtime = 0
        self.current_player = None
        self.player_lock = threading.RLock()
        self.inference_lock = threading.RLock()
        self.queue_cancel_event = threading.Event()
        self.queue_thread = None
        self.running = False
        self.server_socket = None
        self.audio_slot = 0
        self.is_ready = False
        self.load_config()

    def load_config(self):
        try:
            if CONFIG_PATH.exists():
                mtime = CONFIG_PATH.stat().st_mtime
                if mtime != self.config_mtime:
                    with open(CONFIG_PATH, "r", encoding="utf-8") as f:
                        self.config = json.load(f)
                    self.config_mtime = mtime
            else:
                self.config = {
                    "active_voice": "bf_emma",
                    "active_speed": 1.18,
                    "read_mode": "summary",
                    "voices": {
                        "emma": {"id": "bf_emma", "speed": 1.18}
                    }
                }
        except Exception as e:
            sys.stderr.write(f"Error loading config: {e}\n")

    def save_config(self):
        try:
            with open(CONFIG_PATH, "w", encoding="utf-8") as f:
                json.dump(self.config, f, indent=2)
            self.config_mtime = CONFIG_PATH.stat().st_mtime
        except Exception as e:
            sys.stderr.write(f"Error saving config: {e}\n")

    def get_read_mode(self):
        if MODE_PATH.exists():
            try:
                m = MODE_PATH.read_text().strip().lower()
                if m in ("full", "narrative", "all"):
                    return "full"
                if m in ("summary", "short", "digest"):
                    return "summary"
            except Exception:
                pass
        self.load_config()
        return self.config.get("read_mode", "summary")

    def set_read_mode(self, mode):
        clean_mode = "full" if mode in ("full", "narrative", "all") else "summary"
        self.load_config()
        self.config["read_mode"] = clean_mode
        self.save_config()
        MODE_PATH.write_text(clean_mode + "\n")
        return clean_mode

    def get_voice_and_speed(self, requested_voice=None, requested_speed=None):
        self.load_config()
        active_voice = self.config.get("active_voice", "bf_emma")
        active_speed = float(self.config.get("active_speed", 1.18))

        voice = requested_voice or active_voice
        speed = float(requested_speed) if requested_speed is not None else active_speed

        voices = self.config.get("voices", {})
        if voice in voices:
            v_info = voices[voice]
            voice = v_info.get("id", voice)
            if requested_speed is None and "speed" in v_info:
                speed = float(v_info["speed"])

        return voice, speed

    def stop_playback(self):
        # Cancel any multi-chunk queue worker
        self.queue_cancel_event.set()
        if self.queue_thread and self.queue_thread.is_alive():
            self.queue_thread.join(timeout=0.2)

        with self.player_lock:
            if self.current_player and self.current_player.poll() is None:
                try:
                    self.current_player.terminate()
                    self.current_player.wait(timeout=0.2)
                except Exception:
                    try:
                        self.current_player.kill()
                    except Exception:
                        pass
                self.current_player = None
            subprocess.run(["pkill", "-x", "afplay"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(["pkill", "-x", "say"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    def split_into_chunks(self, text, max_chars=350):
        # Break multi-paragraph text into natural acoustic chunks
        paragraphs = [p.strip() for p in text.split("\n\n") if p.strip()]
        chunks = []
        for p in paragraphs:
            if len(p) <= max_chars:
                chunks.append(p)
            else:
                sentences = re.split(r"(?<=[.!?])\s+", p)
                curr = ""
                for s in sentences:
                    if len(curr) + len(s) + 1 <= max_chars:
                        curr = f"{curr} {s}".strip()
                    else:
                        if curr:
                            chunks.append(curr)
                        curr = s
                if curr:
                    chunks.append(curr)
        return chunks if chunks else [text]

    def speak(self, text, voice=None, speed=None, wait=False):
        voice, speed = self.get_voice_and_speed(voice, speed)
        self.stop_playback()
        self.queue_cancel_event.clear()

        chunks = self.split_into_chunks(text)

        # 1. Synthesize Chunk 0 immediately to start playback right away
        with self.inference_lock:
            t0 = time.perf_counter()
            res = self.tts.generate(chunks[0], voice=voice, speed=speed)
            gen_ms = (time.perf_counter() - t0) * 1000

            self.audio_slot = (self.audio_slot + 1) % 10
            out_file = AUDIO_DIR / f"kokoro_alert_{self.audio_slot}.wav"
            sf.write(str(out_file), res.audio, res.sample_rate)

        with self.player_lock:
            player = subprocess.Popen(
                ["afplay", str(out_file)],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )
            self.current_player = player

        # 2. If there are subsequent chunks, pipeline them in a background worker
        if len(chunks) > 1:
            def queue_worker(remaining_chunks, v, s):
                for chunk_text in remaining_chunks:
                    if self.queue_cancel_event.is_set():
                        break

                    # Pre-synthesize while previous audio is playing
                    with self.inference_lock:
                        if self.queue_cancel_event.is_set():
                            break
                        res_next = self.tts.generate(chunk_text, voice=v, speed=s)
                        with self.player_lock:
                            self.audio_slot = (self.audio_slot + 1) % 10
                            next_file = AUDIO_DIR / f"kokoro_alert_{self.audio_slot}.wav"
                            sf.write(str(next_file), res_next.audio, res_next.sample_rate)

                    # Wait for preceding player to finish
                    if player and player.poll() is None:
                        while player.poll() is None:
                            if self.queue_cancel_event.is_set():
                                return
                            time.sleep(0.05)

                    if self.queue_cancel_event.is_set():
                        break

                    # Play next chunk
                    with self.player_lock:
                        p_next = subprocess.Popen(
                            ["afplay", str(next_file)],
                            stdout=subprocess.DEVNULL,
                            stderr=subprocess.DEVNULL
                        )
                        self.current_player = p_next

                    while p_next.poll() is None:
                        if self.queue_cancel_event.is_set():
                            try:
                                p_next.kill()
                            except Exception:
                                pass
                            return
                        time.sleep(0.05)

            self.queue_thread = threading.Thread(
                target=queue_worker,
                args=(chunks[1:], voice, speed),
                daemon=True
            )
            self.queue_thread.start()

        if wait:
            player.wait()
            if self.queue_thread:
                self.queue_thread.join()

        return {
            "status": "ok",
            "voice": voice,
            "speed": speed,
            "chunks": len(chunks),
            "chunk_0_duration": round(res.duration, 3),
            "generation_ms": round(gen_ms, 2)
        }

    def handle_client(self, conn):
        try:
            raw_data = b""
            while True:
                chunk = conn.recv(4096)
                if not chunk:
                    break
                raw_data += chunk
                if b"\n" in raw_data:
                    break

            if not raw_data:
                return

            req = json.loads(raw_data.decode("utf-8").strip())
            action = req.get("action", "speak")

            if action == "speak":
                text = req.get("text", "").strip()
                if not text:
                    res = {"status": "error", "message": "Empty text"}
                elif not self.is_ready:
                    res = {"status": "error", "message": "Model warming up"}
                else:
                    voice = req.get("voice")
                    speed = req.get("speed")
                    wait = req.get("wait", False)
                    res = self.speak(text, voice=voice, speed=speed, wait=wait)

            elif action == "stop":
                self.stop_playback()
                res = {"status": "ok", "message": "Playback stopped"}

            elif action == "mode" or action == "set_mode":
                target_mode = req.get("mode")
                if target_mode:
                    applied = self.set_read_mode(target_mode)
                    res = {"status": "ok", "read_mode": applied}
                else:
                    res = {"status": "ok", "read_mode": self.get_read_mode()}

            elif action == "set_voice" or action == "switch":
                target = req.get("voice")
                speed = req.get("speed")
                voices = self.config.get("voices", {})
                if target in voices:
                    real_id = voices[target].get("id", target)
                    target_speed = speed if speed is not None else voices[target].get("speed", 1.18)
                else:
                    real_id = target
                    target_speed = speed if speed is not None else 1.18

                self.config["active_voice"] = real_id
                self.config["active_speed"] = float(target_speed)
                self.save_config()
                res = {
                    "status": "ok",
                    "active_voice": real_id,
                    "active_speed": float(target_speed)
                }

            elif action == "status" or action == "ping":
                self.load_config()
                res = {
                    "status": "ok",
                    "ready": self.is_ready,
                    "pid": os.getpid(),
                    "active_voice": self.config.get("active_voice"),
                    "active_speed": self.config.get("active_speed"),
                    "read_mode": self.get_read_mode(),
                    "model": "Kokoro-82M-bf16",
                    "backend": "MLX Metal"
                }

            elif action == "voices":
                self.load_config()
                res = {
                    "status": "ok",
                    "voices": self.config.get("voices", {})
                }

            elif action == "shutdown":
                res = {"status": "ok", "message": "Daemon shutting down"}
                conn.sendall((json.dumps(res) + "\n").encode("utf-8"))
                conn.close()
                self.running = False
                return

            else:
                res = {"status": "error", "message": f"Unknown action: {action}"}

            conn.sendall((json.dumps(res) + "\n").encode("utf-8"))
        except Exception as e:
            try:
                err_res = {"status": "error", "message": str(e)}
                conn.sendall((json.dumps(err_res) + "\n").encode("utf-8"))
            except Exception:
                pass
        finally:
            conn.close()

    def start_server(self):
        if SOCKET_PATH.exists():
            try:
                test_s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
                test_s.settimeout(0.5)
                test_s.connect(str(SOCKET_PATH))
                test_s.close()
                sys.stderr.write("Kokoro daemon is already running.\n")
                return
            except Exception:
                SOCKET_PATH.unlink(missing_ok=True)

        PID_FILE.write_text(str(os.getpid()))

        def cleanup_handler(signum, frame):
            self.running = False
            if self.server_socket:
                try:
                    self.server_socket.close()
                except Exception:
                    pass
            SOCKET_PATH.unlink(missing_ok=True)
            PID_FILE.unlink(missing_ok=True)
            self.stop_playback()
            sys.exit(0)

        signal.signal(signal.SIGINT, cleanup_handler)
        signal.signal(signal.SIGTERM, cleanup_handler)

        self.server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.server_socket.bind(str(SOCKET_PATH))
        self.server_socket.listen(16)
        self.running = True

        def accept_loop():
            while self.running:
                try:
                    conn, _ = self.server_socket.accept()
                    client_thread = threading.Thread(target=self.handle_client, args=(conn,), daemon=True)
                    client_thread.start()
                except (socket.error, OSError):
                    if not self.running:
                        break

        listener_thread = threading.Thread(target=accept_loop, daemon=True)
        listener_thread.start()

        sys.stdout.write("Initializing KokoroTTS model on Apple Silicon Metal...\n")
        sys.stdout.flush()
        self.tts = KokoroTTS.from_pretrained()

        self.tts.generate("Ready.", voice="bf_emma", speed=1.18)
        self.is_ready = True
        sys.stdout.write(f"Kokoro daemon ready & listening on {SOCKET_PATH} (PID {os.getpid()})\n")
        sys.stdout.flush()

        try:
            while self.running:
                time.sleep(0.5)
        finally:
            cleanup_handler(None, None)

def send_request(req, timeout=10.0):
    if not SOCKET_PATH.exists():
        return None
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.settimeout(timeout)
        s.connect(str(SOCKET_PATH))
        payload = (json.dumps(req) + "\n").encode("utf-8")
        s.sendall(payload)
        
        resp_data = b""
        while True:
            chunk = s.recv(4096)
            if not chunk:
                break
            resp_data += chunk
            if b"\n" in resp_data:
                break
        s.close()
        return json.loads(resp_data.decode("utf-8").strip())
    except Exception:
        return None

def main():
    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd in ("run", "server"):
            daemon = KokoroDaemon()
            daemon.start_server()
        elif cmd == "status":
            resp = send_request({"action": "status"}, timeout=2.0)
            if resp and resp.get("status") == "ok":
                print(json.dumps(resp, indent=2))
            else:
                print("Kokoro daemon is offline.")
                sys.exit(1)
        elif cmd == "stop":
            resp = send_request({"action": "stop"}, timeout=2.0)
            print(resp or "Failed to connect to daemon.")
        elif cmd in ("mode", "set-mode"):
            target_mode = sys.argv[2] if len(sys.argv) > 2 else None
            req = {"action": "mode"}
            if target_mode:
                req["mode"] = target_mode
            resp = send_request(req, timeout=2.0)
            if resp and resp.get("status") == "ok":
                print(f"Active reading mode: {resp.get('read_mode')}")
            else:
                print("Failed to get/set reading mode.")
        elif cmd == "speak":
            text = sys.argv[2] if len(sys.argv) > 2 else "Kokoro voice system online."
            voice = sys.argv[3] if len(sys.argv) > 3 else None
            speed = float(sys.argv[4]) if len(sys.argv) > 4 else None
            resp = send_request({"action": "speak", "text": text, "voice": voice, "speed": speed, "wait": False})
            if resp and resp.get("status") == "ok":
                print(json.dumps(resp, indent=2))
            else:
                print(resp or "Failed to connect to daemon.")
        elif cmd in ("switch", "set-voice"):
            if len(sys.argv) < 3:
                print("Usage: kokoro_daemon.py switch <voice_alias_or_id> [speed]")
                sys.exit(1)
            target = sys.argv[2]
            speed = float(sys.argv[3]) if len(sys.argv) > 3 else None
            resp = send_request({"action": "switch", "voice": target, "speed": speed})
            print(json.dumps(resp, indent=2) if resp else "Failed to connect to daemon.")
        elif cmd == "voices":
            resp = send_request({"action": "voices"}, timeout=2.0)
            print(json.dumps(resp, indent=2) if resp else "Failed to connect to daemon.")
        elif cmd == "shutdown":
            resp = send_request({"action": "shutdown"}, timeout=2.0)
            print(resp or "Failed to connect to daemon.")
        else:
            print("Usage: kokoro_daemon.py {run|status|stop|mode [summary|full]|speak <text>|switch <voice>|voices|shutdown}")
    else:
        daemon = KokoroDaemon()
        daemon.start_server()

if __name__ == "__main__":
    main()
