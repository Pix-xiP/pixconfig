
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


# function toggle-loopback --description "Toggle microphone loopback to speakers."
#     if PIX_PA_LOOP_ENABLED
#         pactl unload-module module-loopback
#         set -gx PIX_PA_LOOP_ENABLED false
#     else
#         set -gx PIX_PA_LOOP_ENABLED true
#         pactl unload-module module-loopback
#     end
# end
function toggle-loopback --description "Toggle microphone loopback to speakers"
    # Check if PIX_PA_LOOP_ENABLED is set and equals "true"
    if set -q PIX_PA_LOOP_ENABLED[1]; and test "$PIX_PA_LOOP_ENABLED" = true
        # Unload module and set to false
        pactl unload-module module-loopback
        set -g PIX_PA_LOOP_ENABLED false
    else
        # Load module and set to true
        pactl load-module module-loopback
        set -g PIX_PA_LOOP_ENABLED true
    end
end
