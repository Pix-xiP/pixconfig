
# This file is to be loaded when inside a Linux based system.
# Contains setups, functions and aliases specific to this environment.


set SECRETS_PATH /home/pix/.config/fish/secrets.fish
if test -e "$SECRETS_PATH"
    source "$SECRETS_PATH"
end

set -gx GRAVEYARD "/home/pix/.local/graveyard"
set -gx PIXCONFIG /home/pix/AdeptusCustodes/pixconfig

abbr edit "swappy -f"

alias hw='hwinfo --short' # Hardware Info
alias ip='ip -c'
alias valgrind="sudo -E valgrind"
alias kb-config="nvim ~/.config/hypr/keybinds.conf"
