alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fzf --fish | source
zoxide init fish | source

# Voice Narration Controls
alias voice-on="touch ~/.gemini/voice_enabled; and echo 'Voice narration enabled'"
alias voice-off="rm -f ~/.gemini/voice_enabled; and pkill -x afplay 2>/dev/null; and pkill -x say 2>/dev/null; and echo 'Voice narration disabled'"
alias voice-toggle="test -e ~/.gemini/voice_enabled; and voice-off; or voice-on"
alias shh="~/.gemini/config/scripts/kokoro_daemon.py stop 2>/dev/null; pkill -x afplay 2>/dev/null; pkill -x say 2>/dev/null; and echo 'Silenced'"
alias voice-full="~/.gemini/config/scripts/kokoro_daemon.py mode full"
alias voice-summary="~/.gemini/config/scripts/kokoro_daemon.py mode summary"
alias voice-mode="~/.gemini/config/scripts/kokoro_daemon.py mode"

# Voice Persona Switches
alias voice-night="~/.gemini/config/scripts/kokoro_daemon.py switch nicole 1.25; and echo 'Switched to Late-Night Partner (Nicole @ 1.25x)'"
alias voice-latenight="voice-night"
alias voice-day="~/.gemini/config/scripts/kokoro_daemon.py switch emma 1.18; and echo 'Switched to Primary Companion (Emma @ 1.18x)'"
alias voice-emma="voice-day"
alias voice-george="~/.gemini/config/scripts/kokoro_daemon.py switch george 1.15; and echo 'Switched to Sole Backup (George @ 1.15x)'"
alias voice-status="~/.gemini/config/scripts/kokoro_daemon.py status"
alias voice-voices="~/.gemini/config/scripts/kokoro_daemon.py voices"
