function spawn --description "Runs a command in the background completely, no logs, output etc."
    nohup $argv >/dev/null 2>&1 &
    disown
end
