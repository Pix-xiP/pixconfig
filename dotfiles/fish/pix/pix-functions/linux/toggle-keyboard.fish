function toggle-keyboard --description "Toggle keyboard between colemak && qwerty"
    set -l variant (hyprctl getoption input:kb_variant -j | jq -r '.str')

    if test "$variant" = colemak
        hyprctl eval 'hl.config({ input = { kb_layout = "us", kb_variant = "" }})'
        notify-send Keyboard "Switching to Qwerty"
    else
        hyprctl eval 'hl.config({ input = { kb_layout = "us", kb_variant = "colemak" }})'
        notify-send Keyboard "Switching to Colemak"
    end
end
