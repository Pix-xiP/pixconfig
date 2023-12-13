function fzf-s --description 'Fuzzy Search over given file with preview' --argument file
    if not set -q argv[1]
        echo "Hey buddy, you need to give me a file that exists.."
        return
    else if not set -q argv[2]
        cat $file | fzf --marker "=>" \
            --prompt 'MUCK> ' \
            --preview "echo {} | jq | fish_indent --ansi" \
            --preview-window "top:75%:wrap" \
            --multi \
            --cycle \
            --layout reverse \
            --border \
            --bind "shift-up:preview-up" \
            --bind "shift-down:preview-down"
    else
        cat $file | fzf --marker "=>" \
            --prompt 'MUCK> ' \
            --preview "echo {} | jq | fish_indent --ansi" \
            --preview-window "top:75%:wrap" \
            --multi \
            --cycle \
            --layout reverse \
            --border \
            --bind "shift-up:preview-up" \
            --bind "shift-down:preview-down" | jq >$argv[2]
    end
end
