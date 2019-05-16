alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

function grbo {
  git rebase -i origin/$(git_current_branch) # Function from OMZ
}

function gcot {
  git checkout --track origin/${1##origin/}
}
