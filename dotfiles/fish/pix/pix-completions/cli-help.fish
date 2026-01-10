# easy completions for the cli-help utility

complete -e cli-help

complete --command cli-help --exclusive --long help -d "Print help"

complete --command cli-help --exclusive -a help -d "Print help"
complete --command cli-help --exclusive -a yazi -d "Open yazi docs"
complete --command cli-help --exclusive -a fzf -d "Show fzf help"
complete --command cli-help --exclusive -a nvim -d "Open nvim docs"
