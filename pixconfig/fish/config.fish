function pix_print_osc7 --description "Prints OSC7 for the terminal to use"
    set wez_current_dir_var (pwd)

    printf "\033]7;file://%s/%s\033\\" $hostname $wez_current_dir_var

end

if status is-interactive
    # Commands to run hn interactive sessions can go here
    fzf_configure_bindings --directory=\cf --git_log=\e\f --history=\cg
    fish_config theme choose "Rosé Pine"
    pix_print_osc7
    atuin init fish --disable-up-arrow | source
end

## TODO: Make a generic PATH variable for MAC and Linux.

# Specific to Mac
if test (uname) = Darwin
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

    function brew --description "Wraps brew and sends a sketchybar trigger"
        command brew $argv
        sketchybar --trigger brew_update
    end

    function wez_update --description "Update nightly version of Wezterm"
        echo "Running update"
        command brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
        echo Updated
    end
end

# Specific to Linux
if test (uname) = Linux
    set SECRETS_PATH /home/pix/.config/fish/secrets.fish
    if test -e "$SECRETS_PATH"
        source "$SECRETS_PATH"
    end
    set -gx WEZTERM_CONFIG_FILE "/home/pix/.config/wezterm/wezterm.lua"
    set -gx GRAVEYARD "/home/pix/.local/graveyard"
    set -x ODIN_ROOT /home/pix/AdeptusCustodes/Odin
    set -gx PIXCONFIG /home/pix/AdeptusCustodes/pix_hyprland/pixconfig/

    abbr edit "swappy -f"

    alias hw='hwinfo --short' # Hardware Info
end

# How to make zoxide run
zoxide init --cmd z fish | source

# ===================
# Alias Hours
# ===================
alias cat="bat --style header --style snip --style changes --style header"
alias zerotier-cli="sudo zerotier-cli"
alias df="duf"
alias du="dust"
alias diff="icdiff"
alias vim="nvim"
alias docker="sudo docker"
alias gg="git pull"
alias md="gum format"
alias n="nvim"
alias wz="wezterm"
alias imgcat="wezterm imgcat"
alias valgrind="sudo -E valgrind"
alias tree="eza -g --icons --sort=type --tree"
alias rustscan="docker run -it --rm --name rustscan rustscan/rustscan:2.1.1"
alias pq="pueue"

# ===================
# Abbr Hours
# ===================
abbr rsync "rsync -avP --progress --verbose"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"
abbr wz-config "nvim ~/.config/wezterm/wezterm.lua"
abbr re-src "source ~/.config/fish/config.fish"
abbr rg "rg --color=auto"
abbr rgc "rg --color=always --column --line-number --smart-case --no-heading"
abbr fping "ping -c 20 -i.2"
abbr ls "eza -g --icons --sort=type"
abbr ll "eza -g --icons --sort=type -lah"
abbr zt zerotier-cli
abbr lg lazygit
abbr trip "sudo trip"

# ====================
# EXPORTS - (Not unique to either platform)
# ====================
# Set X for export :: Set G for global
set -x C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
set fzf_preview_dir_cmd eza --all --color=always

# ===================
# FUNCTIONS  (that aren't in their own fish files)
# ===================
function xtar --argument filename
    tar -I pixz -cvf $filename.tar.xz $filename
end

# Quick backup!
function bak --argument filename --description "Makes a very quick in place backup of a file or directory"
    cp -vr $filename $filename.bak
end

function peep --argument file --description "Open a file with FZF with search and preview"
    cat $file | fzf --preview "echo {} | fish_indent --ansi" --preview-window="top:5:wrap"
end

set -Ux FZF_DEFAULT_OPTS '--color=fg:#908caa,hl:#ea9a97 
                        --color=border:#44415a,header:#3e8fb0,gutter:#232136
                        --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
                        --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
                        --cycle --layout=reverse --border --height=95% 
                        --preview-window=wrap 
                        --marker="=>" 
                        --bind "shift-up:preview-up,shift-down:preview-down"'

# function fzf --wraps="fzf"
#     set -Ux FZF_DEFAULT_OPTS '
#       --color=fg:#908caa,bg:#232136,hl:#ea9a97
#       --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
#       --color=border:#44415a,header:#3e8fb0,gutter:#232136
#       --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
#       --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
#       --cycle
#       --layout=reverse
#       --border
#       --height=95%
#       --preview-window=wrap
#       --marker="=>"
#       --bind "shift-up:preview-up,shift-down:preview-down"
#       '
#     command fzf
# end

# Ez cat SSH pub key
function get_pub_key --description "Quickly cat out public file"
    /bin/cat "$KEY_PATH"
end
