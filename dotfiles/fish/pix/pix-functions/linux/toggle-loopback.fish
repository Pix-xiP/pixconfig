function toggle-loopback --description "Toggle microphone loopback to speakers"
    # Check if PIX_PA_LOOP_ENABLED is set and equals "true"
    if set -q PIX_PA_LOOP_ENABLED; and test "$PIX_PA_LOOP_ENABLED" = true
        # Unload module and set to false
        pactl unload-module module-loopback
        set -g PIX_PA_LOOP_ENABLED false
    else
        # Load module and set to true
        pactl load-module module-loopback
        set -g PIX_PA_LOOP_ENABLED true
    end
end
