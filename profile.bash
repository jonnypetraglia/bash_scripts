# Bash
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export PS1="\[\e[0;33m[\h \A \w]\e[m\]\[\e[1;31m\$\e[m\] "

# See git.bash for `git-diff-count` implementation
export PS1='\n∴\h\$ in \w $(git-diff-count)         \@\n  ↳'
export PS1="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬\n$PS1"
export EDITOR=vim

###### Path

# Android SDK
if [ -z {$ANDROID_HOME+x} ]; then
  export ANDROID_HOME="$HOME/sdk";
fi
export PATH="$ANDROID_HOME/platform-tools:$PATH";

# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
path="$PATH:$HOME/.gem/ruby/current/bin"

