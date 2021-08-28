##########################
# <spencerb@honeycomb.net>
##########################

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Save each command to the history file as it's executed.  #517342
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
PROMPT_COMMAND='history -a'

#If facter is installed, grab IP address:
if [[ $SSH_CONNECTION ]]; then
     tmpsship=($(echo "$SSH_CONNECTION" | tr ' ' '\n'))
     IP_ADDRESS=${tmpsship[2]}
     unset tmpsship
else
     IP_ADDRESS=`/usr/bin/env facter --no-ruby ipaddress`
fi

# Change the window title of X terminals
# this is redundant because we set the title of the window in TITLEBAR in color_my_prompt
case ${TERM} in
    [aEkx]term*|rxvt*|gnome*|konsole*|interix)
        PS1='\[\033]0;\u@\h:\w\007\]'
        ;;
    screen*)
        PS1='\[\033k\u@\h:\w\033\\\]'
        ;;
    *)
        unset PS1
        ;;
esac
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
# set this to 1 if you want a pretty prompt
usecolor=1

function getenv() {
    # get the server name of the FQDN
    servername=$(basename `hostname` .honeycomb.net)

    # split the server name on the dashes to an array
    hostnameArr=(${servername//-/ })

    if [ ${BASH_VERSINFO[0]} -eq 4 ] && [ ${BASH_VERSINFO[1]} -ge 3 ]; then
      # this is for versions of bash 4.3 and above.
      # this way is more flexible and futureproof than the alternate way
      # select the last element in the array
      env=${hostnameArr[-1]}
    else
      # this is for versions of bash from 4.0 to 4.2
      # bash v5.0 will fallback to here as well
      # this forces the format "mn-hc-bserver-p1".. it is not flexible
      # select the fourth element in the array
      env=${hostnameArr[3]}
    fi

    # strip the number from the environment identifier
    torp=$(echo $env | tr -cd '[[:alpha:]]')

    [ "$torp" == "p" ] && echo "[PROD] "
    [ "$torp" == "t" ] && echo "[TEST] "
    [ "$torp" == "d" ] && echo "[DEV] "
}

function color_my_prompt_user {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    local p=$(getenv)
    export PS1="$p${TITLEBAR}$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

function color_my_prompt_root {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local __user_and_host="\[\033[01;31m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    local p=$(getenv)
    export PS1="$p${TITLEBAR}$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

function dont_color_my_prompt {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local p=$(getenv)
    export PS1="$p${TITLEBAR}\u@\h:\w\$ "
}

if [[ $usecolor -eq 1 ]]; then
  if [[ $UID -eq 0 ]]; then
    color_my_prompt_root
  else
    color_my_prompt_user
  fi
else
    dont_color_my_prompt
fi

# 
export EDITOR="vim"

# load bash completion
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]] && \
    . /usr/local/share/bash-completion/bash_completion

# override global completions with our own
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Set ls colors on bsd to match Linux
if [[ $OSTYPE =~ bsd ]] ; then
  export LSCOLORS=ExGxFxdaCxDaDahbaDacec
fi

# Set up system specific aliases
if [[ $OSTYPE == "linux-gnu" ]] ; then
  alias ls="ls --color"
  alias ll="ls -lap --color"
elif [[ $OSTYPE =~ freebsd* ]] ; then 
  alias ls="ls -G"
  alias ll="ls -lapG"
elif [[ $OSTYPE =~ openbsd* ]] ; then
  alias ls="colorls -G"
  alias ll="colorls -lapG" 
  alias sudo="sudo -c ldap"
else
  alias ll="ls -lap"
fi

alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"

# special edition by spencer
HISTTIMEFORMAT='%F %T '

# I'd rather not have to use ^h in vim to backspace dot dot dotfile
stty erase '^?'


unset -f color_my_prompt_user
unset -f color_my_prompt_root
unset -f dont_color_my_prompt
unset -f getenv

mkpass () {
  IFS=
  local len="${1-8}"
  local chars=({A..z} {0..9})
  local xtra='#!{}().,'
  local charset="${chars[*]}$xtra"
  while [ 0 -ne "$len" ]; do
    local pass="$pass${charset:$(($RANDOM%${#charset})):1}"
    let len--
  done
echo "$pass"
}

dig_qa () {
  for qa in "$@"; do
    dig "$qa" | egrep -A1 '(QUEST|ANSW.*SEC)'|sed -e 's/--//g'; echo
  done
}

