# Local Ambient Voice System (Apple Silicon Kokoro-82M TTS)

This directory contains the Apple Silicon-optimized voice narration system and Antigravity (AGY) hook integration.

## Architecture

1. **`kokoro_daemon.py`**:
   - High-throughput MLX Metal TTS engine running local `Kokoro-82M` weights.
   - Pipelined audio generation: pre-synthesizes speech chunks concurrently while preceding audio plays via `afplay`.
   - Listens on UNIX domain socket `~/.gemini/kokoro.sock`.
   - Supports instant switching between voice personas (`emma`, `nicole`, `george`) and reading modes (`summary` vs `full`).

2. **`voice_alert.py`**:
   - Antigravity AGY `Stop` hook script.
   - Automatically triggered when an AGY task completes.
   - Parses the conversation transcript, extracts the spoken voice digest tag (`<!-- VOICE: ... -->`), strips code/markdown noise, and requests speech from the Kokoro daemon (falling back to macOS `say` if offline).

3. **`agy-voice`**:
   - Convenient CLI wrapper script for controlling the daemon.

4. **`voice_config.json` & `voice_preferences_profile.json`**:
   - Persona definitions, speeds, phonetic pronunciations, and active configurations.

5. **`hooks.json`**:
   - AGY hook configuration defining the `Stop` event handler.

## Shell Controls (Fish)

- `voice-on` / `voice-off` / `voice-toggle`: Toggle voice narration.
- `shh`: Instantly stop active speech and silence daemon.
- `voice-summary` / `voice-full`: Toggle concise spoken digest vs full response narration.
- `voice-day` (Emma @ 1.18x) / `voice-night` (Nicole @ 1.25x) / `voice-george` (George @ 1.15x): Switch persona.
- `voice-status`: Check daemon status, latency, and active settings.
