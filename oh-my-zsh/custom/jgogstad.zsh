alias vim=nvim

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Node version manager
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Z
. /usr/local/etc/profile.d/z.sh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup pyenv
export PATH=$(pyenv root)/shims:$PATH

## Don't let brew know about pyenv
alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'

# Setup virtualenv home
export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

# Tell pyenv-virtualenvwrapper to use pyenv when creating new Python environments
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# Add GCP to PATH
export PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH"

# PATH customizations
export PATH="$HOME/development/personal/dotfiles/bin:$PATH"

## Homebrew sometimes install stuff to sbin (brew doctor will complain if not in PATH)
export PATH="/usr/local/sbin:$PATH"
alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'

# Yubikey
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Color config
export LESS=-r
alias jq="jq -C"
alias grep="grep --color=always"
alias stripcolors='sed -E "s/[[:cntrl:]]\[[0-9]{1,3}m//g"'

# ~/.oh-my-zsh/lib/theme-and-appearance.zsh
unalias ls # OMZ aliases ls to `ls -G`, put exa on path as `ls` instead

# ~/.oh-my-zsh/lib/directories.zsh
# Remove -h (ls: human readable, exa: header line)
# Change -A to -a (show all except . and ..)
alias lsa='ls -la'
alias l='ls -la'
alias ll='ls -l'
alias la='ls -la'

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_GITHUB_API=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# ZSH
setopt histignorespace

## Enable sharing of history across multiple sessions
#setopt inc_append_history
setopt share_history

# Make Ctrl+U behave like in bash (remove from cursor until beginning of prompt)
bindkey \^U backward-kill-line

# Don't add certain patterns to ZSH history file
function zshaddhistory() {
    emulate -L zsh
    if [[ "$1" =~ "^  " ]]; then
        print -Sr -- "${1%%$'\n'}"
        fc -p
    elif ! [[ "$1" =~ "(^ykchalresp |^ |password|PASSWORD|VAULT_TOKEN)" ]] ; then
        print -Sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
  }

function nowrap {
  (tput rmam && $@; tput smam)
}

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

# Update PATH
export PATH="$HOME/bin:$HOME/development/personal/dotfiles/bin:$HOME/development/tapad/gcp-integration/gcp-utils/src/main/bash:/usr/local/opt/scala@2.11/bin:$PATH"
