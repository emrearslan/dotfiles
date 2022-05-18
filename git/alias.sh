alias remlocalbranches="git branch | grep -v '^*' | xargs git branch -D && git fetch --prune"

alias pull-work='find $WORK_PATH -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git checkout && git pull" \;'
alias pull-team='find $TEAM_PATH -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git checkout && git pull" \;'

alias dev-pull='git checkout develop && git pull'
alias master-pull='git checkout master && git pull'

batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}