# function __ssh_agent_running
#     if set -q SSH_CONNECTION
#         ssh-add -l >/dev/null 2>&1
#         contains $status 0 1; and return 0
#     end
#
#     test -f "$SSH_ENV"; and test -z "$SSH_AGENT_PID"; and source "$SSH_ENV" >/dev/null
#     test -z "$SSH_AGENT_PID"; and return 1
#
#     ssh-add -l >/dev/null 2>&1; or test $status -eq 2; and return 1
# end
function __ssh_agent_running
    if test -n "$SSH_CONNECTION"
        # This is an SSH session
        ssh-add -l >/dev/null 2>&1
        if test $status -eq 0 -o $status -eq 1
            # An SSH agent was forwarded
            return 0
        end
    end

    if begin
            test -f "$SSH_ENV"; and test -z "$SSH_AGENT_PID"
        end
        source $SSH_ENV >/dev/null
    end

    if test -z "$SSH_AGENT_PID"
        return 1
    end

    ssh-add -l >/dev/null 2>&1
    if test $status -eq 2
        return 1
    end
end
