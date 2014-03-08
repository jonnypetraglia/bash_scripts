# Bash
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export PS1="\[\e[0;33m[\h \A \w]\e[m\]\[\e[1;31m\$\e[m\] "
export EDITOR=vim

# DAT PATH
export PATH="$HOME/sdk/platform-tools:$PATH"
# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
path="$PATH:$HOME/.gem/ruby/current/bin"

# May have come from Macports
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH


# YEAH ALIASES BITCH
alias ccd="clear && cd"
alias resource="source ~/.bash_profile"
alias cl="clear"
alias cls="clear && ls"
alias mktar="tar -cvf"
alias mkbz2="tar -cvjf"
alias mkgz="tar -cvzf"
alias untar="tar -xvf"
alias unbz2="tar -xvjf"
alias ungz="tar -xvzf"
alias ll="ls -al --color=auto"
alias brokensim="find -L . -type l -exec ls -lF --color=yes '{}' +"
alias sshvnc="ssh -L 5901:localhost:5901"



# Functions
ccdls() {
    clear && cd "$1" && ls
}
cdls() {
    cd "$1" && ls
}
function exterminate() { kill -KILL $(pgrep "$1"); }
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

