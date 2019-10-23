# These git aliases are compatible, and dependent on, the OMZ git plugin (for git_current_branch), https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git

alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

function gs {
  if [[ $# -eq 0 ]]; then
    echo "git stash save -u <message>"
  else
    git stash save -u "$@"
  fi
}

alias gsp='git stash pop'

function gbll {
  git for-each-ref --sort=committerdate refs/heads/ --format="%(committerdate:short)|%(refname:short)|%(committername)" | while IFS='|' read date branch name; do 
    printf "%s %-40s %s\n" "$date" "$branch" "$name"
  done
}

function gblo {
  git for-each-ref --sort=committerdate refs/remotes/origin --format="%(committerdate:short)|%(refname:short)|%(committername)" | while IFS='|' read date branch name; do 
    printf "%s %-40s %s\n" "$date" "${branch##origin/}" "$name"
  done
}

function grbo {
  git rebase -i origin/$(git_current_branch) # Function from OMZ
}
