# This file is to be loaded when inside a Darwin based system.
# Contains setups, functions and aliases specific to this environment.
if status is-interactive
    /opt/homebrew/bin/brew shellenv | source
end

functions --erase q

if test -e (path resolve $__fish_config_dir/pix/work.fish)
    source (path resolve $__fish_config_dir/pix/work.fish)
end

set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx GRAVEYARD "$HOME/.local/graveyard"
set -gx ODIN_ROOT "$HOME/AdeptusCustodes/Fenris/Odin"
set -gx WEZTERM_CONFIG_FILE "$HOME/.config/wezterm/wezterm.lua"

# Go Env Setup
set -gx GOPATH /Users/pix/AdeptusCustodes/Ultramar/
set -gx GOROOT /opt/homebrew/opt/go/libexec

# Add to the general path
contains "$HOME/AdeptusCustodes/Ultramar/bin" $PATH; or set -ga PATH "$HOME/AdeptusCustodes/Ultramar/bin"
# contains /opt/homebrew $PATH; or set -ga PATH /opt/homebrew
# contains /opt/homebrew/bin $PATH; or set -ga PATH /opt/homebrew/bin
contains "$HOME/.cargo/bin" $PATH; or set -ga PATH "$HOME/.cargo/bin"

set -x LLVM_CONFIG /opt/homebrew/Cellar/llvm/18.1.8/bin/llvm-config
set -gx LUA_INIT "@/Users/pix/.config/lua/init.lua"

function zt_restart --description "Restarts the ZeroTier daemon for when you're having trouble"
    echo "Unloading..."
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
    ip route
    sleep 5
    echo "Reloading..."
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
    ip route
    echo "Done!"
end

# function brew --description "Wraps brew and sends a sketchybar trigger and checks for yabai"
#     command brew $argv
#     sketchybar --trigger brew_update
# end

function update_ghostty --description "Automatically updates the Ghostty Terminal"
    pushd ~/AdeptusCustodes/Talassar/ghostty
    echo "Running ghostty build."
    git pull
    zig build -Doptimize=ReleaseFast
    cd macos && xcodebuild
    echo "Done building"
    popd
end
