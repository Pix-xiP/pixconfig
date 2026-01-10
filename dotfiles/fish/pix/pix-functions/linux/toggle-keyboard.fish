function toggle-keyboard --description "Toggles keyboard between colemak && qwerty"
    set -l input_dir $HOME/.config/hypr/pix.hypr
    set -l target $input_dir/input.conf
    set -l colemak $input_dir/colemak.input.conf
    set -l qwerty $input_dir/qwerty.input.conf

    # Use 'readlink' and 'string match' for cleaner logic
    if test -L $target
        set -l current (readlink $target)

        # String match is faster and more readable than basename + test
        if string match -q "*colemak*" $current
            echo "Switching to QWERTY..."
            ln -sf $qwerty $target
        else
            echo "Switching to Colemak..."
            ln -sf $colemak $target
        end
    else
        echo "Initializing Colemak layout..."
        ln -sf $colemak $target
    end

    echo "Current layout: "(readlink $target | path basename)
    hyprctl reload
end
