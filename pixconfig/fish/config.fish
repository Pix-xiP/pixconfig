if status is-interactive
    # Commands to run hn interactive sessions can go here
    fzf_configure_bindings --directory=\cf --git_log=\e\f
    fish_config theme choose "Rosé Pine"

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
alias imgcat="wezterm imgcat"
alias valgrind="sudo -E valgrind"
alias tree="eza -g --icons --sort=type --tree"

# Abbr Hours
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
abbr edit "swappy -f"

# ====================
# EXPORTS
# ====================
# Set X for export
# Set G for global
set -x PATH "/opt/homebrew/opt/gnu-getopt/bin:$PATH"
set -x C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
# Includes for Mac homebrew if using it cross platform.
set -x PATH "/opt/homebrew:$PATH"
set -x PATH "/opt/homebrew/bin:$PATH"
set -gx WEZTERM_CONFIG_FILE "/home/pix/.config/wezterm/wezterm.lua"
set -gx GRAVEYARD "/home/pix/.local/graveyard"
set -x ODIN_ROOT /home/pix/AdeptusCustodes/Odin
set -x EDITOR nvim

set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=95% --preview-window=wrap --marker="=>" --bind "shift-up:preview-up,shift-down:preview-down"'

if test (uname) = Linux
    set -gx PIXCONFIG /home/pix/AdeptusCustodes/pix_hyprland/pixconfig/

else if test (uname) = Darwin
    set -gx PIXCONFIG /Users/pix/AdeptusCustodes/pix_hyprland/pixconfig/
else
    set -gx PIXCONFIG "./"
end

# ===================
# FUNCTIONS  (that aren't in their own fish files)
# ===================
function xtar --argument filename
    tar -I pixz cvf $filename.tar.xz $filename
end

# Quick backup!
function backup --argument filename
    cp $filename $filename.bak
end

function fzf --wraps="fzf"
    set -Ux FZF_DEFAULT_OPTS '
      --color=fg:#908caa,bg:#232136,hl:#ea9a97
      --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
      --color=border:#44415a,header:#3e8fb0,gutter:#232136
      --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
      --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
      --cycle 
      --layout=reverse 
      --border 
      --height=95% 
      --preview-window=wrap 
      --marker="=>" 
      --bind "shift-up:preview-up,shift-down:preview-down"
      '
    command fzf
end

# Ez cat SSH pub key
function get_pub_key --description "Quickly cat out public file"
    /bin/cat ~/.ssh/id_rsa.pub
end
