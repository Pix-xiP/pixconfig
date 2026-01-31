# This file is to be loaded when inside a Linux based system.
# Contains setups, functions and aliases specific to this environment.
abbr edit "swappy -f"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"

alias ip='ip -c'

# remove the likely preset one.
alias q 'qs -c ii'
alias task go-task

fish_add_path -a "$HOME/.local/bin" "$HOME/.local/share/gem/ruby/3.4.0/bin"
