# This file is to be loaded when inside a Linux based system.
# Contains setups, functions and aliases specific to this environment.

abbr edit "swappy -f"
abbr hypr-config "nvim ~/.config/hypr/hyprland.conf"

alias ip='ip -c'
alias valgrind="sudo -E valgrind"

# remove the likely preset one.
functions --erase q
alias q 'qs -c ii'

contains "$HOME/.local/bin" $PATH; or set -ga PATH "$HOME/.local/bin"
contains "$HOME/.local/share/gem/ruby/3.4.0/bin" $PATH; or set -ga PATH "$HOME/.local/share/gem/ruby/3.4.0/bin"

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

function toggle-keyboard --description "Toggles keyboard between colemak && qwerty"
    # Define the configuration directory and files
    set target_link "$HOME/.config/hypr/pix.hypr/input.conf"
    set colemak_source "$HOME/.config/hypr/pix.hypr/colemak.input.conf"
    set qwerty_source "$HOME/.config/hypr/pix.hypr/qwerty.input.conf"

    # Check if the symlink exists
    if test -L $target_link
        # Get where the symlink points to
        set current_target (readlink $target_link)
        # echo "colemak: $colemak_source"
        # echo "qwerty: $qwerty_source"

        if test (basename $current_target) = (basename $colemak_source)
            echo "Switching from Colemak to QWERTY..."
            rm $target_link
            ln -s $qwerty_source $target_link

        else if test (basename $current_target) = (basename $qwerty_source)
            echo "Switching from QWERTY to Colemak..."
            rm $target_link
            ln -s $colemak_source $target_link
        end
    else
        # No symlink exists, default to Colemak \o/
        echo "Setting up Colemak layout..."
        ln -s $colemak_source $target_link
    end

    # Verify the final state
    echo "Current layout: " (readlink $target_link)

    hyprctl reload
end
