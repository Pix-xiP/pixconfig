function pix_print_osc7 --description "Prints OSC7 for the terminal to use"
    set wez_curr_dir (pwd)

    printf "\033]7;file://%s/%s\033\\" $hostname $wez_curr_dir
end

if status is-interactive
    # Commands to run hn interactive sessions can go here
    fzf_configure_bindings --directory=\cf --git_log=\e\f --history=\cg
    fish_config theme choose "Rosé Pine"
    pix_print_osc7
    atuin init fish --disable-up-arrow | source
    zoxide init --cmd z fish | source
end

if test (uname) = Darwin
    if test -e "/Users/pix/.config/fish/darwin.fish"
        source "/Users/pix/.config/fish/darwin.fish"
    end
else if test (uname) = Linux
    if test -e "./home/pix/.config/fish/linux.fish"
        source "./home/pix/.config/fish/linux.fish"
    end
end

# ===================
# Set / Export Hours 
# ===================
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

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
alias pq="pueue"
alias ls="eza -g --icons --sort=type"
alias makego="go mod init; go mod tidy; touch main.go"
alias go_get_all="go get -u -v -f all"


# ===================
# Abbr Hours
# ===================
abbr nb goread
abbr rsync "rsync -avP --progress --verbose"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"
abbr wz-config "nvim ~/.config/wezterm/wezterm.lua"
abbr ghost-config "nvim ~/.config/ghostty/config"
abbr re-src "source ~/.config/fish/config.fish"
abbr rg "rg --color=auto"
abbr rgc "rg --color=always --column --line-number --smart-case --no-heading"
abbr fping "ping -c 20 -i.2"
abbr ll "eza -g --icons --sort=type -lah"
abbr zt zerotier-cli
abbr lg lazygit
abbr trip "sudo trip"

# ====================
# EXPORTS - (Not unique to either platform)
# ====================
# Set X for export :: Set G for global
set -gx C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"

# ===================
# General environment set variables
# ===================
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
#       --marker="= >"
#       --bind "shift-up:preview-up,shift-down:preview-down"
#       '
#     command fzf
# end

# Ez cat SSH pub key
function get_pub_key --description "Quickly cat out public file"
    /bin/cat "$KEY_PATH"
end
