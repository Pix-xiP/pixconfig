function man --wraps man --description "Format and display man pages"
    set -l umbral_red (set_color -o da3c69)
    set -l ubmral_blue (set_color -o 6c4dff)
    set -l umbral_yellow (set_color ffd369)
    set -l umbral_orange (set_color -u e9729d)
    set -l end (printf "\e[0m")

    set -lx LESS_TERMCAP_mb $umbral_red # _mb = BLINK
    set -lx LESS_TERMCAP_md $ubmral_blue # _md = BOLD
    set -lx LESS_TERMCAP_me $end # _me = END SPECIAL MODE
    set -lx LESS_TERMCAP_so $umbral_yellow # _so = STANDOUT
    set -lx LESS_TERMCAP_se $end # _se = END SPECIAL MODE
    set -lx LESS_TERMCAP_us $umbral_orange # _us = UNDERLINE
    set -lx LESS_TERMCAP_ue $end # _ue = REMVOVE UNDERLINE
    set -lx LESS '-R -s'
    set -lx GROFF_NO_SGR yes

    set -lx MANPATH (string join : $MANPATH)
    if test -z "$MANPATH"
        type -q manpath
        and set MANPATH (command manpath)
    end

    set -l fish_manpath (dirname $__fish_data_dir)/fish/man
    if test -d "$fish_manpath" -a -n "$MANPATH"
        set MANPATH "$fish_manpath":$MANPATH
        command man $argv
        return
    end

    command man $argv
end
