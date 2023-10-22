if status is-interactive
    # Commands to run hn interactive sessions can go here
end

# How to make zoxide run
zoxide init --cmd z fish | source

# Alias Hours
alias cat="bat --style header --style snip --style changes --style header"
alias zerotier-cli="sudo zerotier-cli"
alias df="duf"
alias du="dust"
alias diff="icdiff"
alias vim="nvim"
alias docker="sudo docker"
alias gg="git pull"
alias n="nvim"
alias wz="wezterm"

# Abbr Hours
abbr rsync "rsync -avP --progress --verbose"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"
abbr wz-config "nvim ~/.config/wezterm/wezterm.lua"
abbr re-src "source ~/.config/fish/config.fish"
abbr grep "rg --color=auto"
abbr rg "rg --color=auto"
abbr fping "ping -c 20 -i.2"
abbr ls "eza -g --sort=type"
abbr ll "eza -g --sort=type -lah"
abbr zt zerotier-cli
abbr lg lazygit

# Set X for export
set -x PATH "/opt/homebrew/opt/gnu-getopt/bin:$PATH"
set -x C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
# Includes for Mac homebrew if using it cross platform.
set -x PATH "/opt/homebrew:$PATH"
set -x PATH "/opt/homebrew/bin:$PATH"

# XZ Tar file
function xtar --argument filename
    tar cvJf $filename.tar.xz $filename
end

# Quick backup!
function backup --argument filename
    cp $filename $filename.bak
end

# Peco keybindings
function fish_user_key_bindings
    bind \cr fzf_history # ctrl + r
    bind \cf fzf_file # ctrl + f 
end

function sudobangbang --on-event fish_postexec
    abbr -g !! sudo $argv[1]
end

set -gx WEZTERM_CONFIG_FILE "/home/pix/.config/wezterm/wezterm.lua"
set -gx GRAVEYARD "/home/pix/.local/graveyard"

function __history_previous_command --description "Replacement for Bash 'sudo !!' command to run last commmand with sudo"
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# Ez cat SSH pub key
function get_pub_key --description "Quickly cat out public file"
    /bin/cat ~/.ssh/id_rsa.pub
end

set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
