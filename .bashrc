# BASHRC
# Spencer Butler <spencerb@honeycomb.net>

[ -d "${HOME}/.local/bin" ] && PATH=${PATH}:${HOME}/.local/bin
export PROMPT_COMMAND='history -a'

# set this to 1 if you want a pretty prompt
usecolor=1

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# override global completions with our own
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Set ls colors on bsd to match Linux
if [[ ${OSTYPE} == *"bsd"* ]] ; then
  # dark blue directories
  #export LSCOLORS=ExGxFxdaCxDaDahbaDacec
  # light blue directories
  export LSCOLORS="ExGxFxdxCxDxDxhbadExEx";
else
  export LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh  =01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.wa  r=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=0  1;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;  35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.cfg=00;32:*.conf=00;32:*.diff=00;32:*.doc=00;32:*.ini=00;32:*.log=00;32:*.p  atch=00;32:*.pdf=00;32:*.ps=00;32:*.tex=00;32:*.txt=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
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

##############################
## FUNCTION
##############################
function color_my_prompt_user_short_pwd {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\W"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="${TITLEBAR}$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

function color_my_prompt_user {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="${TITLEBAR}$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

function color_my_prompt_root {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    local __user_and_host="\[\033[01;31m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="${TITLEBAR}$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}

function dont_color_my_prompt {
    local TITLEBAR="\[\033]0;${IP_ADDRESS} \u@\h:\w\007\]"
    export PS1="$p${TITLEBAR}\u@\h:\w\$ "
}

start_ssh_agent() {
    local _SSH_KEY=${1:-~/.ssh/id_ed25519}
    if [ -z $SSH_AUTH_SOCK ]; then
        if [ -f $_SSH_KEY ]; then
            eval $(ssh-agent -s) > ~/.ssh_agent
            ssh-add $_SSH_KEY >> ~/.ssh_agent
        fi
    fi
}

short_pwd() {
    # Shorten many directories in my PS1.
    SHORT_PWD=1
    [ $1 ] && SHORT_PWD=0
    source ~/.bashrc
}

fix_storage_dirs () {
    sudo find ${1} -type f -exec chmod 0664 {} \;
    sudo find ${1} -type d -exec chmod 0775 {} \;
    sudo chown -R $(whoami):www ${1}
}

urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

genpasswd () {
    local l=$1
        [ "$l" == "" ] && l=20
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

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

if [[ $usecolor -eq 1 ]]; then
  if [[ $UID -eq 0 ]]; then
    color_my_prompt_root
  else
    if [[ $SHORT_PWD -eq 1 ]]; then
      color_my_prompt_user_short_pwd
    else
        color_my_prompt_user
    fi
  fi
else
    dont_color_my_prompt
fi

parse_logtime() {
    # dmesg style timestamp decoder
    local ERR="$1"
    local BOOT="$(date +%s -d "$(uptime -s)")"
    local ERR_DATE="$(( BOOT + ERR ))"
    date -d @"$ERR_DATE"
}

parse_time() {
    # VAL is seconds
    local VAL="${1:-$(date +%s)}"
    local _year=year
    local _month=month
    local _day=day
    local _hour=hour
    local _min=min
    local _sec=sec
    local year="$(( 60*60*24*365 ))"
    local month="$(( (60*60*24*365)/12 ))"
    local day="$(( 60*60*24 ))"
    local hour="$(( 60*60 ))"

    local YEAR="$(( VAL / year ))";        local year_sec="$(( VAL % year ))"
    local MONTH="$(( year_sec / month ))"; local month_sec="$(( year_sec % month ))"
    local DAY="$(( month_sec / day ))";    local day_sec="$(( month_sec % day ))"
    local HOUR="$(( day_sec / hour ))";    local hour_sec="$(( day_sec % hour ))"
    local MIN="$(( hour_sec / 60 ))"
    local SEC="$(( hour_sec % 60 ))"

    [ "$YEAR"  -gt 1 ] && _year=years
    [ "$MONTH" -gt 1 ] && _month=months
    [ "$DAY"   -gt 1 ] && _day=days
    [ "$HOUR"  -gt 1 ] && _hour=hours
    [ "$MIN"   -gt 1 ] && _min=mins
    [ "$SEC"   -gt 1 ] && _sec=secs

    if [ "$YEAR" = 0 -a "$MONTH" = 0 -a "$DAY" = 0 -a "$HOUR" = 0 ]; then
        OUT="$MIN $_min $SEC $_sec"
    elif [ "$YEAR" = 0 -a "$MONTH" = 0 -a "$DAY" = 0 ]; then
        OUT="$HOUR $_hour $MIN $_min $SEC $_sec"
    elif [ "$YEAR" = 0 -a "$MONTH" = 0 ]; then
        OUT="$DAY $_day $HOUR $_hour $MIN $_min $SEC $_sec"
    elif [ "$YEAR" = 0 ]; then
        OUT="$MONTH $_month $DAY $_day $HOUR $_hour $MIN $_min $SEC $_sec"
    else
        OUT="$YEAR $_year $MONTH $_month $DAY $_day $HOUR $_hour $MIN $_min $SEC $_sec"
    fi
    echo $OUT
}

#############################
# ALIAS
#############################

# colorize ls output
# Set up system specific aliases
if [[ $OSTYPE =~ "linux-" ]] ; then
  alias ls="ls --color"
  alias ll="ls -l --color"
  alias lla="ls -al --color"
elif [[ $OSTYPE =~ freebsd* ]] ; then
  alias ls="ls -G"
  alias ll="ls -lG"
  alias lla="ls -lG"
elif [[ $OSTYPE =~ openbsd* ]] ; then
  alias ls="colorls -G"
  alias ll="colorls -lG"
  alias lla="colorls -lG"
  alias sudo="sudo -c ldap"
else
  alias ll="ls -lap"
fi
alias ..="cd .."
alias ssh_unsafe="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias scp_unsafe="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias ssh-insecure="ssh_unsafe"
alias scp-insecure="scp_unsafe"

alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gc="git commit -m '$@'"
alias git-push-master="git push -u origin master"
if command -v nvim >/dev/null
then
  alias vim="nvim"
fi
alias pylint="pylint --rcfile ~/.pylintrc"

# Docker ##################################
alias dps="docker ps"
alias dc="docker compose"
alias di="docker image"
alias dil="docker image ls"
alias dv="docker volume"
alias dvl="docker volume ls"
alias dn="docker network"
alias dnl="docker network ls"
alias ds="docker service"
alias dsl="docker service ls"

dps_name() {
    docker ps -f name=$@
}

dps_exec() {
    docker exec -it $(docker ps -f name=$1 -q | head -n1) ${2:-sh}
}

dps_logs() {
    id=$(docker ps -f name=$1 -q | head -n1)
    docker logs $2 $id
}

# End Docker ###############################

export HISTSIZE=1000000 SAVEHIST=1000000
export EDITOR=vim
export GIT_EDITOR=vim
export HISTCONTROL=ignoredups
# make sure LANG is set to en_US.utf8
export LANG=en_US.UTF-8

# dont show me "Display all 105 possibilities" when pressing tab to complete the git branch
# https://superuser.com/a/601997
set completion-query-items 1000
# Enable tab completion for sudo commands https://unix.stackexchange.com/a/345205
#complete -cf sudo
# I'd rather not have to use ^h in vim to backspace dot dot dotfile
stty erase '^?'


unset -f color_my_prompt_user
unset -f color_my_prompt_root
unset -f dont_color_my_prompt

