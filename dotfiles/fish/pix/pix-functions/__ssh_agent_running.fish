function __ssh_agent_running
    if set -q SSH_CONNECTION
        ssh-add -l >/dev/null 2>&1
        contains $status 0 1; and return 0
    end

    test -f "$SSH_ENV"; and test -z "$SSH_AGENT_PID"; and source "$SSH_ENV" >/dev/null
    test -z "$SSH_AGENT_PID"; and return 1

    ssh-add -l >/dev/null 2>&1; or test $status -eq 2; and return 1
end
