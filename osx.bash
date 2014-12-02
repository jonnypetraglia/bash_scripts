if [[ "$(uname)" == "Darwin" ]]; then

## https://github.com/Ruxton/shell_config/blob/master/.profile.d/osx_aliases.bash

# truecrypt: TrueCrypt command line
alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/Truecrypt --text'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'


## Trash a file from cli
trash() { command mv "$@" ~/.Trash; }

# rm_DS_Store: removes all .DS_Store file from the current dir and below
alias rm_DS_Store='find . -name .DS_Store -exec rm {} \;'

# cdf: cd's to frontmost window of Finder
cdf ()
{
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

alias cvlc="/Applications/VLC.app/Contents/MacOS/VLC -I rc"

alias get_profile_img="dscl . -read $HOME JPEGPhoto | tail -1 | xxd -r -p > $HOME/profile_pic.jpg"

alias py2applet="/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin/py2applet"


brewcompletion_path="/usr/local/etc/bash_completion.d/"

function brewcompletion() {
  ln -s "$HOME/.bash_completion.d/$1" "/usr/local/etc/bash_completion.d/$1"
}
complete -F _bash_complete_alllister brewcompletion

#
#Usage
#
#$ __selector "Select a volume" "selected_volume" "" "`ls -la /Volumes/`"
#$ cd $selected_volume
#
# __selector: good for selecting stuff
function __selector() {
  local selections selPrompt selCurrent selListCommand selSize choose

  selPrompt=$1
  selReturn=$2
  selCurrent=$3
  selList=$4

  prompt=$selPrompt

  let count=0

  for sel in $selList; do
    let count++
    selections[$count-1]=$sel
  done
  if [[ $count > 0 ]]; then
    choose=0
    selSize=${#selections[@]}

    while [ $choose -eq 0 ]; do
      let count=0

      for sel in $selList; do
        let count++
        echo "$count) $sel"
      done

      echo

      read -ep "${prompt}, followed by [ENTER]:" choose

      if [[ $choose != ${choose//[^0-9]/} ]] || [ ! $choose -le $selSize ]
      then
        echo
        echo "Please choose one of the listed numbers."
        echo
        let choose=0
      fi

    done

    let choose--

    export ${selReturn}=${selections[$choose]}
  else
    return 0
  fi
}

osx_real_path () {
  OIFS=$IFS
  IFS='/'
  for I in $1
  do
    # Resolve relative path punctuation.
    if [ "$I" = "." ] || [ -z "$I" ]
      then continue
    elif [ "$I" = ".." ]
      then FOO="${FOO%%/${FOO##*/}}"
           continue
      else FOO="${FOO}/${I}"
    fi

    # Dereference symbolic links.
    if [ -h "$FOO" ] && [ -x "/bin/ls" ]
      then IFS=$OIFS
           set `/bin/ls -l "$FOO"`
           while shift ;
           do
             if [ "$1" = "->" ]
               then FOO=$2
                    shift $#
                    break
             fi
           done
    fi
  done
  IFS=$OIFS
  echo "$FOO"
}

fi
