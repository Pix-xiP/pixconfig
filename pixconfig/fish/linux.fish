
# This file is to be loaded when inside a Linux based system.
# Contains setups, functions and aliases specific to this environment.


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
