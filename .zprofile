# PATH additions — appended (not prepended) so system binaries
# always resolve first; a compromised ~/.local/bin can't shadow sudo etc.
[ -d "$HOME/.cargo/bin" ] && PATH="$PATH:$HOME/.cargo/bin"
[ -d "$HOME/go/bin" ] && PATH="$PATH:$HOME/go/bin"
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/bin" ] && PATH="$PATH:$HOME/bin"

# PlatformIO Xtensa ESP32-S3 toolchain
[ -d "$HOME/.platformio/packages/toolchain-xtensa-esp32s3/bin" ] && PATH="$PATH:$HOME/.platformio/packages/toolchain-xtensa-esp32s3/bin"
export PATH

# propagate to launchd so GUI apps (Finder/Dock/Spotlight-launched) see it too
# — takes effect on next login or app relaunch, not immediately
launchctl setenv PATH "$PATH"
