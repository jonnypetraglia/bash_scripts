## https://github.com/Ruxton/shell_config/blob/master/.profile.d/generic_aliases.bash

### Re-defining some commands (remember \command runs the original)
alias mkdir="mkdir -pv"
alias screen="screen -s -/bin/bash"


### Other shorthands
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias ccd="clear && cd"
alias cl="clear"
alias cls="clear && ls"
alias ll="ls -a l"
alias l1="ls -1"
alias lm="ls -al | more"
alias lc="ls -C"
# Show the number of online users
alias nu="who|wc -l"
# Show active processes
alias p="ps -ef"
# Show number of active processes
alias np="ps -ef|wc -l"
# dirs: Show only directories in the current directory
alias dirs="ls -al | grep '^d'"
# dirscount: Number of directories in current directory
alias dirscount="ls -al|grep ^d|wc -l"
# Show bash history
alias h="history | more"
# mk{archive} & un{archive}
alias mktar="tar -cvf"
alias mkbz2="tar -cvjf"
alias mkgz="tar -cvzf"
alias untar="tar -xvf"
alias unbz2="tar -xvjf"
alias ungz="tar -xvzf"
# SSH into a VNC instance running on the machine
alias sshvnc="ssh -L 5901:localhost:5901"
# Restore terminal settings when screwed up
alias fix_stty="stty sane"
# Generates a date in the same format that Rails uses. I used it once.
alias railsdate='date -u +"%Y%m%d%H%M%S"'
# Re-Source
alias resource="source ~/.bash_profile"


## Functions & function-ish aliases
# Finds broken symlinks in the current directory
alias brokensym="find -L . -type l -exec ls -lF --color=yes '{}' +"

## Make dir & change to it
mcd() { mkdir -p "$1" && cd "$1"; }

## ClearCDLS
ccdls() {
    clear && cd "$1" && ls
}
## CDLS

cdls() {
    cd "$1" && ls
}


# cpbak: quickly copy/backup a directory
cpbak() {
  local dirname basename

  dirname=`abspath $1`
  basename=`basename $dirname`

  cp -R $dirname ${dirname}.bak
}

# bak: Backup a file "bak filename.txt"
bak() {
  cp $1 ${1}--`date +%Y%m%d%H%M`.bak
}



## Kill a process
function exterminate() { kill -KILL $(pgrep "$1"); }

## Compare the MD5s of two files
function md5compare()
{
  if [[ $# -lt 1 ]]
  then
    echo "Dude you have to pass AT LEAST ONE file"
    return 1
  fi
  num=0
  for var in "$@"
  do
    num=$(($num + 1))
    if [[ $(md5sum "$var" | awk '{print $1}') != $(md5sum "$1" | awk '{print $1}') ]]
    then
      echo NOPE! The following file differs:
      md5sum "$1"
      md5sum "$var"
      return 1
    fi
  done
  echo These $num files are the same
  return 0
}
alias md5cmp=md5compare

# abspath: absolute path of a directory
function abspath() {
  return=`cd ${1%/*} 2>/dev/null; echo "$PWD"`
  echo $return
}

# user_confirm: Confirm with a string in $1
function user_confirm() {
  local REPLY msg
  msg=$1
  read -ep "$msg (y/n):" -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Reads a value from the user providing a default if the user enters nothing
# read_with_defaults: $1=prompt $2=default $3=variable to set
function read_with_defaults() {
  local return_var
  prompt=$1
  default=$2

  read -e -p "$prompt [$default]: " return_var
  return_var=${return_var:-$default}
  eval $3=\$return_var
}

# I don't even use screen
# __screend: screen daemonizing
__screend() {
  local name="${1}"
  local check=`screen -list|grep ${name}|awk '{print $1}'`

  if [[ "$2" = "" ]]; then
    if [[ "${check}" = "" ]]; then
      echo "Starting ${name}..."
      screen -dmS ${name} bash -c '${name}'
      local runCheck=`screen -list|grep ${name}|awk '{print $1}'`
      if [[ "${runCheck}" = "" ]]; then
        echo "Unable to start ${name} in background"
      else
        echo "Started ${name} in background"
      fi
    else
      echo "${name} is running in background..."
      read -ep "re-attach? (y/n)" choice
      if [[ $choice = [yY] ]]; then
        echo "Attaching ${name} session..."
        screen -r ${check}
      else
        echo "${name} currently running at ${check}"
      fi
    fi
  else
    if [[ $2 -eq "load" ]]; then
      screen -r ${name}
    fi
  fi
}
