if [[ "$(uname)" == "Linux" ]]; then

alias pacnew="find / -regextype posix-extended -regex \".+\.pac(new|save|orig)\" 2> /dev/null"
alias wine="if which wine; then echo no wine for: ; return; fi; /opt/wine-compholio/bin/wine $1"


fi
