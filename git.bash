alias gpom="git pull origin master"
alias gpot="git push origin -f --tags"
alias git-mergetest="git merge --no-commit --no-ff"
alias gitpush='git push origin $(git rev-parse --abbrev-ref HEAD)'

# Count the # of changes by author for the repo as it currently stands
#   http://stackoverflow.com/questions/4589731/git-blame-statistics
alias git-blame-count="git ls-tree --name-only -z -r HEAD | xargs -0 -n1 git blame --line-porcelain | grep '^author ' | sed -e 's/^author //;' | sed 's/notbryant/Jon Petraglia/g;' | sed 's/MrQweex/Jon Petraglia/g;' | sort | uniq -c | sort -nr"
# Count the # of changes & other stats for the repo over all time
#  It has 3 sections:
#    Added/Changed/Removed      displays sheer # of changes, like git blame
#    %Added/%Changed/%Removed   displays how the ratio of the above number to the total # of changes of that type
#    Files/%Files               displays the # of files & % of files that the user has modified
#    Commits/%Commits           displays the # of commits & % of commits contributed
alias git-score="git log --numstat | awk -f ~/.bash/git_score.awk"

# Counts the number of changes to the git repo you are currently in, if you are in one
function git-diff-count() {
  if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
    num=`git diff --shortstat 2>/dev/null | (awk '{print $4+$6}')` 
    if [[ -n "$num" ]]; then
      echo [±$num]
    else
      echo [clean]
    fi
  else
    echo ""
  fi
}