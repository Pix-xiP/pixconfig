set -q SSH_ENV; or set -xg SSH_ENV "$HOME/.ssh/environment"

if not __ssh_agent_running
    __ssh_agent_start
end
