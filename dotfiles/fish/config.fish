# IF ITS GONNA BE USED NOT JUST INVOKED
if status is-interactive
    # Commands to run hn interactive sessions can go here
    fish_config theme choose PinkNPurplePix
    atuin init fish --disable-up-arrow | source
    zoxide init --cmd z fish | source
    contains /home/pix/go/bin $PATH; or set -ga PATH /home/pix/go/bin
    cod init %self fish | source
end

if test (uname) = Darwin
    if test -e "/Users/pix/.config/fish/darwin.fish"
        source "/Users/pix/.config/fish/darwin.fish"
    end
else if test (uname) = Linux
    if test -e "/home/pix/.config/fish/linux.fish"
        source "/home/pix/.config/fish/linux.fish"
    end
end

if test -e "/Users/pix/.config/fish/work.fish"
    source "/Users/pix/.config/fish/work.fish"
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
alias n="nvim"
alias tree="eza -g --icons --sort=type --tree"
alias pq="pueue"
alias ls="eza -g --icons --sort=type"
alias go-get-all="go get -u -v all"
alias fm="fastmod"
alias scratch="nvim /tmp/scratchie"

# ===================
# Abbr Hours
# ===================
abbr nb goread
abbr rsync "rsync -avP --progress --verbose"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"
abbr ghost-config "nvim ~/.config/ghostty/config"
abbr re-src "source ~/.config/fish/config.fish"
abbr rg "rg --color=auto"
abbr rgc "rg --color=always --column --line-number --smart-case --no-heading"
abbr fping "ping -c 20 -i.2"
abbr ll "eza -g --icons --sort=type -lah"
abbr zt zerotier-cli
abbr lg lazygit
abbr trip "sudo trip"
abbr mkdir "mkdir -p"

# ====================
# EXPORTS - (Not unique to either platform)
# ====================
# Set X for export :: Set G for global
set -gx C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
set -gx ZEIT_DB "$HOME/.config/zeit/zeit.db"

contains "$HOME/.local/bin" $PATH; or set -ga PATH "$HOME/.local/bin"

set -x LLVM_CONFIG /opt/homebrew/Cellar/llvm/18.1.8/bin/llvm-config

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

# set -Ux LS_COLORS "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.md=38;5;68:*.log=38;5;68:*.c=38;5;169:*.h=38;5;135:*.o=38;5;97:*.y=38;5;99:*.l=38;5;99:*.sh=38;5;104"
# set -Ux EXA_COLORS "*.md=38;5;68:*.log=38;5;68:*.c=38;5;169:*.h=38;5;135:*.o=38;5;97:*.y=38;5;99:*.l=38;5;99:*.sh=38;5;104"

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

function sync_folder --description "Syncs a folder with a remote server" -a FOLDER REMOTE REMOTE_PATH
    rsync -azuvP $FOLDER $REMOTE:$REMOTE_PATH
end
