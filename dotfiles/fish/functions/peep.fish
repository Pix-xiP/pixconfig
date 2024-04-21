function peep --description 'Open a file with preview and searchable context' --argument file
    bat $file | fzf --preview "echo {} | fish_indent --ansi" --preview-window="bottom:5:wrap" --multi
end
