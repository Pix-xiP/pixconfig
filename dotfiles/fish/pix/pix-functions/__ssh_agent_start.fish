function __ssh_agent_start
    ssh-add -c | string replace -r "^echo" "#echo" >$SSH_ENV
    chmod 600 $SSH_ENV # handle enforced permissions
    source $SSH_ENV >/dev/null
end
