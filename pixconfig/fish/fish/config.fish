if status is-interactive
    # Commands to run hn interactive sessions can go here
end

# How to make zoxide run
fish_add_path -m /opt/homebrew/bin/
zoxide init --cmd z fish | source

# Alias Hours
alias cat="bat --style header --style snip --style changes --style header"
alias hw='hwinfo --short' # Hardware Info
alias zerotier-cli="sudo zerotier-cli"
#alias rg="rg --color=auto"
alias df="duf"
alias du="dust"
alias diff="icdiff"
alias vim="nvim"
alias docker="sudo docker"
alias gg="git pull"


# Abbr Hours
abbr rsync "rsync -avP --progress --verbose"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
abbr re-src "source ~/.config/fish/config.fish"
abbr grep "rg --color=auto"
abbr rg "rg --color=auto"
abbr fping "ping -c 20 -i.2"
abbr ls "exa -g --sort=type"
abbr ll "exa -g --sort=type -lah"
abbr zt zerotier-cli
abbr ks "kitty +kitten ssh"
abbr lg lazygit

# Set X for export
set -x PATH "/opt/homebrew/opt/gnu-getopt/bin:$PATH"
set -x C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
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

# Peco commands for fast lookup
function peco_select_history_order
    if test (count $argv) = 0
        set peco_flags --layout=top-down
    else
        set peco_flags --layout=bottom-up --query "$argv"
    end

    history | peco $peco_flags | read foo

    if [ $foo ]
        commandline $foo
    else
        commandline ''
    end
end

# Fish fix for lack of !! from bash
#function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
#    if test "$argv" = !!
#    eval command sudo $history[1]
#else
#    command sudo $argv
#    end
#end

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
    /bin/cat ~/.ssh/pix_key.pub
end

set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

function ff
    rm -rf ./build
    meson build
    cd build
    meson compile
    cd ..
end
