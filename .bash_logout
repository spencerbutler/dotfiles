# delete ssh-keyes and kill any ssh-agent that we may have running
ssh-add -D &>/dev/null
ssh-agent -k &>/dev/null

# remove our `.ssh_agent` pseudo lockfile
[ -f ~/.ssh_agent ] && rm ~/.ssh_agent 

# Clear the screen for security's sake.
clear

