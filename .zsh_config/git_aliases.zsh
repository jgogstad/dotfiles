# Compatibility with oh-my-zsh git plugin
if ! [[ ${+commands[git_current_branch]} ]]; then 
  git_current_branch () {
  	local ref
  	ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  	local ret=$?
  	if [[ $ret != 0 ]]
  	then
  		[[ $ret == 128 ]] && return
  		ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
  	fi
  	echo ${ref#refs/heads/}
  }
fi

alias glol='git log --graph --pretty='\''%Cred%h%Creset %C(yellow)%G?%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias grhs='git reset --soft'
alias grhss='git reset --soft HEAD^1'

function grho {
  git reset --hard origin/$(git_current_branch)
}

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
