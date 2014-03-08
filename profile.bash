# Bash
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export PS1="\[\e[0;33m[\h \A \w]\e[m\]\[\e[1;31m\$\e[m\] "


# DAT PATH
export PATH="$HOME/sdk/platform-tools:$PATH"
# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# May have come from Macports
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH


# YEAH ALIASES BITCH
alias ccd="clear && cd"
alias resource="source ~/.bash_profile"
alias cl="clear"
alias cls="clear && ls"



# Functions
ccdls() {
    clear && cd "$1" && ls
}
cdls() {
    cd "$1" && ls
}
