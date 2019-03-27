alias glol="git log --graph --pretty='%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty='%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias grhs='git reset --soft'
alias grhss='git reset --soft head^1'

gcot() {
  git checkout --track origin/"$1"
}
