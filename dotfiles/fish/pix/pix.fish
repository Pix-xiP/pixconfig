# Use this copy paste in the 'config.fish' to include the rest of my stuff
# allows for easy testing of other stuff from people! :D
#
# # Hook the rest of my stuff :>
# set pixfish "$HOME/.config/fish/pix/pix.fish"
# if test -f $pixfish
#     source $pixfish
# else
#     echo "Unable to load $pixfish"
# end
# End hook

# ===================
# Hooks and Autoloading
# ===================

set -l pix_dir $__fish_config_dir/pix

functions --erase q

# add functions and completions 
set -a fish_function_path (path resolve $pix_dir/pix-functions)
set -a fish_complete_path (path resolve $pix_dir/pix-completions)
path filter -f $pix_dir/pix-conf.d/*.fish | while read -l conf
    # set base (basename $conf) # for debugging whats actually being sourced
    # echo "Loading $base"
    source $conf
end

# # Include additions from Pix.
# set -a fish_function_path (path resolve $__fish_config_dir/pix/pix-functions)
# set -a fish_complete_path (path resolve $__fish_config_dir/pix/pix-completions)
# for conf in (path resolve $__fish_config_dir/pix/pix-conf.d/*.fish)
#     # set base (basename $conf) # for debugging whats actually being sourced
#     # echo "Loading $base"
#     source $conf
# end

# ===================
# Interactive Blocks
# ===================
if status is-interactive
    fish_config theme choose Umbral ## my theme <3
    type -q atuin; and atuin init fish --disable-up-arrow | source
    type -q zoxide; and zoxide init --cmd z fish | source
    # TODO: Create my own starship version? Write loaders for different stuff to improve it?
end

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
alias fm="fastmod"
alias scratch="nvim /tmp/scratchie"

# ===================
# Abbr Hours
# ===================
abbr nb goread
abbr rsync "rsync -avP"
abbr fish-config "nvim ~/.config/fish/config.fish"
abbr ssh-config "nvim ~/.ssh/config"
abbr nvim-config "nvim ~/.config/nvim/init.lua"
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

# ===================
# OS Specific Blocks && Secrets
# ===================

switch (uname)
    case Darwin
        set -l os_file $pix_dir/darwin.fish
        test -f $os_file; and source $os_file
        set -a fish_function_path (path resolve $pix_dir/pix-functions/darwin)
    case Linux
        set -l os_file $pix_dir/linux.fish
        test -f $os_file; and source $os_file
        set -a fish_function_path (path resolve $pix_dir/pix-functions/linux)
end

test -f $pix_dir/secrets.fish; and source $pix_dir/secrets.fish

# ===================
# Env and Paths
# ===================
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx C_INCLUDE_PATH "/usr/local/include:$C_INCLUDE_PATH"
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# # Add a follow up localised bin
# contains "$HOME/.local/bin" $PATH; or set -ga PATH "$HOME/.local/bin"
# contains "$HOME/AdeptusCustodes/pix-bin" $PATH; or set -ga PATH "$HOME/AdeptusCustodes/pix-bin"
# contains "$HOME/AdeptusCustodes/Ultramar/bin" $PATH; or set -ga PATH "$HOME/AdeptusCustodes/Ultramar/bin"
# contains "$HOME/.cargo/bin" $PATH; or set -ga PATH "$HOME/.cargo/bin"
# TODO: validate this doesn't just kepe adding
fish_add_path -a "$HOME/.local/bin" \
    "$HOME/AdeptusCustodes/pix-bin" \
    "$HOME/AdeptusCustodes/Ultramar/bin" \
    "$HOME/.cargo/bin"

# ===================
# General environment set variables
# ===================
set -Ux FZF_DEFAULT_OPTS '--color=fg:#908caa,hl:#ea9a97 
                          --color=border:#44415a,header:#3e8fb0,gutter:#232136
                          --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
                          --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
                          --cycle --layout=reverse --border --height=95% 
                          --preview-window=wrap 
                          --marker="=>" 
                          --bind "shift-up:preview-up,shift-down:preview-down"'
set fzf_preview_dir_cmd "eza --all --color=always"

function qbackup --argument filename --description "Makes a very quick in place backup of a file or directory"
    cp -vr $filename $filename.bak
end
