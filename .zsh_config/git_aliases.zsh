# These git aliases are compatible, and dependent on, the OMZ git plugin, https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git

alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

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
