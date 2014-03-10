alias gpom="git pull origin master"
alias gpot="git push origin -f --tags"
alias git-mergetest="git merge --no-commit --no-ff"
alias railsdate='date -u +"%Y%m%d%H%M%S"'
alias gitpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
#http://stackoverflow.com/questions/4589731/git-blame-statistics
alias gitcontrib="git ls-tree --name-only -z -r HEAD | xargs -0 -n1 git blame --line-porcelain | grep '^author ' | sed -e 's/^author //;' | sed 's/notbryant/Jon Petraglia/g;' | sed 's/MrQweex/Jon Petraglia/g;' | sort | uniq -c | sort -nr"
