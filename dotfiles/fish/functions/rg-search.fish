function rg-search
    set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
    #set INITIAL_QUERY "\${*:-}"
    set INITIAL_QUERY (or $INITIAL_QUERY "*")
    : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --bind "start:reload:$RG_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind "ctrl-n:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --prompt '1. ripgrep> ' \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
end
