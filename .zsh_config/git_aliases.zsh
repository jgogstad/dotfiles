alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

function gcot {
  git checkout --track origin/${1##origin/}
}

function rc {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  non_rc=${current_branch%-rc}

  if [[ "$current_branch" == HEAD ]]; then 
    echo "Need to have a branch checked out" >&2
  else 
    rc_branch="${non_rc}-rc"
    git rev-parse --abbrev-ref "$rc_branch" >/dev/null 2>&1

    if [[ $! -ne 0 ]]; then
      git checkout -b "$rc_branch"
    else 
      if [[ "$current_branch" == "$non_rc" ]]; then
        git checkout "$rc_branch"
        git reset --hard "$non_rc"
      else
        git checkout "$non_rc"
      fi
    fi
  fi
}
