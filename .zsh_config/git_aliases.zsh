alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

function gblo {
  git for-each-ref --sort=committerdate refs/heads/ --format="%(committerdate:short)|%(refname:short)|%(committername)" | while IFS='|' read date branch name; do 
    printf "%s %-40s %s\n" "$date" "$branch" "$name"
  done
}

function grbo {
  git rebase -i origin/$(git_current_branch) # Function from OMZ
}

function gcot {
  git checkout --track origin/${1##origin/}
}

