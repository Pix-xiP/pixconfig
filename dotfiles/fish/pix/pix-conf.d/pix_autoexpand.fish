status is-interactive || exit

function __pix_expand_bindings --on-variable fish_key_bindings
    set -l modes
    if test "$fish_key_bindings" = fish_default_key_bindings
        set modes default insert
    else
        set modes insert default
    end

    bind --mode $modes[1] . __pix_expand_dots
    bind --mode $modes[1] ! __pix_expand_bang
end

__pix_expand_bindings
