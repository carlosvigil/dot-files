#!/usr/bin/env python3
import sys
import json
import os
import re
import socket
import subprocess

def get_read_mode():
    mode_file = os.path.expanduser("~/.gemini/voice_mode")
    if os.path.exists(mode_file):
        try:
            with open(mode_file, "r", encoding="utf-8") as f:
                m = f.read().strip().lower()
                if m in ("full", "narrative", "all"):
                    return "full"
                if m in ("summary", "short", "digest"):
                    return "summary"
        except Exception:
            pass

    config_file = os.path.expanduser("~/.gemini/voice_config.json")
    if os.path.exists(config_file):
        try:
            with open(config_file, "r", encoding="utf-8") as f:
                cfg = json.load(f)
                return cfg.get("read_mode", "summary")
        except Exception:
            pass
    return "summary"

def extract_narrative_text(content):
    # Strip VOICE tag
    t = re.sub(r"<!--\s*VOICE:.*?-->", "", content, flags=re.DOTALL)
    # Strip fenced code blocks
    t = re.sub(r"```[\s\S]*?```", "", t)
    # Strip markdown table rows and divider lines
    lines = [l for l in t.splitlines() if not l.strip().startswith("|") and not re.match(r"^\s*[-|:]+\s*$", l)]
    t = "\n".join(lines)
    # Strip images
    t = re.sub(r"!\[.*?\]\(.*?\)", "", t)
    # Strip raw URLs and file URIs
    t = re.sub(r"https?://\S+", "", t)
    t = re.sub(r"file:///\S+", "", t)
    # Convert markdown links [label](...) -> label
    t = re.sub(r"\[(.*?)\]\(.*?\)", r"\1", t)
    # Strip header markers
    t = re.sub(r"#+\s*", "", t)
    # Strip backticks
    t = re.sub(r"`([^`]*)`", r"\1", t)
    # Strip bold / italic markers
    t = re.sub(r"\*\*([^*]+)\*\*", r"\1", t)
    t = re.sub(r"\*([^*]+)\*", r"\1", t)
    # Convert list bullets to smooth pauses
    t = re.sub(r"^\s*[-*•]\s*", "", t, flags=re.MULTILINE)
    t = re.sub(r"^\s*\d+\.\s*", "", t, flags=re.MULTILINE)
    # Collapse multiple blank lines
    t = re.sub(r"\n{3,}", "\n\n", t)
    return t.strip()

def speak_via_kokoro(text, socket_path):
    if not os.path.exists(socket_path):
        return False
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.settimeout(0.5)
        s.connect(socket_path)
        s.settimeout(8.5)
        payload = (json.dumps({"action": "speak", "text": text, "wait": False}) + "\n").encode("utf-8")
        s.sendall(payload)
        
        raw_resp = b""
        while True:
            chunk = s.recv(4096)
            if not chunk:
                break
            raw_resp += chunk
            if b"\n" in raw_resp:
                break
        s.close()
        resp = json.loads(raw_resp.decode("utf-8").strip())
        return resp.get("status") == "ok"
    except Exception:
        return False

def fallback_say(text):
    try:
        subprocess.run(["pkill", "-x", "say"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(["pkill", "-x", "afplay"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        pass
    try:
        # If fallback text is huge, speak first 3 sentences so say does not run indefinitely
        sentences = re.split(r"(?<=[.!?])\s+", text.replace("\n", " "))
        fallback_text = " ".join(sentences[:3]) if len(sentences) > 3 else text
        subprocess.Popen(["say", "-r", "215", fallback_text], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        pass

def main():
    toggle_file = os.path.expanduser("~/.gemini/voice_enabled")
    if not os.path.exists(toggle_file):
        print(json.dumps({}))
        return

    try:
        data = json.load(sys.stdin)
    except Exception:
        data = {}

    transcript_path = data.get("transcriptPath")
    speech_text = None

    if transcript_path and os.path.exists(transcript_path):
        try:
            with open(transcript_path, "r", encoding="utf-8", errors="ignore") as f:
                lines = f.readlines()
            for line in reversed(lines):
                try:
                    entry = json.loads(line)
                    content = entry.get("content", "")
                    source = entry.get("source", "")
                    entry_type = entry.get("type", "")
                    if content and (source in ("MODEL", "PLANNER_RESPONSE") or entry_type == "PLANNER_RESPONSE"):
                        mode = get_read_mode()
                        if mode == "full":
                            speech_text = extract_narrative_text(content)
                            if speech_text:
                                break
                        else:
                            # Summary mode: prioritize dedicated VOICE tag
                            voice_match = re.search(r'<!--\s*VOICE:\s*(.*?)\s*-->', content, re.DOTALL)
                            if voice_match:
                                speech_text = voice_match.group(1).strip()
                                break
                            
                            # Fallback: first 2 sentences of cleaned narrative
                            cleaned = extract_narrative_text(content)
                            if cleaned:
                                sentences = re.split(r'(?<=[.!?])\s+', cleaned.replace('\n', ' '))
                                speech_text = " ".join(sentences[:2])
                                break
                except Exception:
                    continue
        except Exception:
            pass

    if not speech_text:
        print(json.dumps({}))
        return

    try:
        subprocess.run(["pkill", "-x", "say"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        pass

    socket_path = os.path.expanduser("~/.gemini/kokoro.sock")
    success = speak_via_kokoro(speech_text, socket_path)
    if not success:
        fallback_say(speech_text)

    print(json.dumps({}))

if __name__ == "__main__":
    main()
