
# This file is to be loaded when inside a Darwin based system.
# Contains setups, functions and aliases specific to this environment.

# Secrets not in github <3
set SECRETS_PATH /Users/pix/.config/fish/secrets.fish
if test -e "$SECRETS_PATH"
    source "$SECRETS_PATH"
end

# Nix Specific 
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

# fish_add_path -m /opt/homebrew/bin/

set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx GRAVEYARD "/Users/pix/.local/graveyard"
set -gx ODIN_ROOT /Users/pix/AdeptusCustodes/Fenris/Odin

set -gx WEZTERM_CONFIG_FILE "/Users/pix/.config/wezterm/wezterm.lua"

# Using -m prevents it from being added multiple times.
fish_add_path -m /opt/homebrew
fish_add_path -m /opt/homebrew/bin
fish_add_path -m /opt/homebrew/opt/gnu-getopt/bin
fish_add_path -m /Users/pix/.config/go_env/bin

# Go Env Setup
set -gx GOPATH /Users/pix/.config/go_env/
set -gx GOROOT /opt/homebrew/opt/go/libexec
# FOR LIB PQ BULLSHIT
set -gx LDFLAGS -L/opt/homebrew/opt/libpq/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/libpq/include
# For C#
set -gx DOTNET_ROOT /opt/homebrew/bin/dotnet
set -gx PIXCONFIG /Users/pix/AdeptusCustodes/pix_hyprland/pixconfig/

set -gx LUA_INIT "@/Users/pix/.config/lua/init.lua"

function zt_restart --description "Restarts the ZeroTier daemon for when you're having trouble"
    echo "Unloading..."
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
    echo "Reloading..."
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
    echo "Done!"
end

function brew --description "Wraps brew and sends a sketchybar trigger and checks for yabai"
    if contains -- upgrade $argv
        set outdated (brew outdated)
        if string match -q yabai $outdated
            echo "Found Yabai, running Yabai specific upgrade first"
            command _brew_update_yabai
        end
    end
    command brew $argv
    sketchybar --trigger brew_update
end

function wez_update --description "Update nightly version of Wezterm"
    echo "Running update"
    command brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
    echo Updated
end

function _brew_update_yabai --description "Does the extra steps needed for yabai update"
    yabai --stop-service
    yabai --uninstall-service
    brew upgrade yabai
    yabai --start-service
    yabai --restart-service
end
