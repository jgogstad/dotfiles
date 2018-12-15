# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

DEFAULT_USER=josteingogstad
# Path to your oh-my-zsh installation.
export ZSH=/Users/$DEFAULT_USER/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

function calculate_gcloud_cache_value {
  local active=$(cat ~/.config/gcloud/active_config)
  local last_change=$(stat -f%m ~/.config/gcloud/configurations/config_$active)
  echo -n "${active}_$last_change"
}

function gcloud_cache_get_or_update {
  local current_cache_value=$(calculate_gcloud_cache_value)
  local value_file=~/Library/Caches/Powerlevel9k/gcloud_${current_cache_value}_$1.cache

  if ! [[ -f $value_file ]]; then
    mkdir -p $(dirname $value_file)
    gcloud config get-value $1 > $value_file
  fi

  echo -n $(<$value_file)
}

function prompt_gcp_project {
  local project=$(gcloud_cache_get_or_update project)
  $1_prompt_segment "$0" "$2" white black "$project" "GCP_PROJECT_ICON"
}

function prompt_gcp_user {
  local username=$(gcloud_cache_get_or_update account)
  local icon

  if [[ $username == *"iam.gserviceaccount.com" ]]; then
    icon=GCP_SERVICE_ACCOUNT_ICON
  else
    icon=GCP_USER_ICON
  fi

  $1_prompt_segment "$0" "$2" white black "${username%@*}" "$icon"
}

prompt_kube_context() {
  local kubectl_version="$(kubectl version --client 2>/dev/null)"

  if [[ -n "$kubectl_version" ]]; then
    # Get the current Kuberenetes context
    local cur_ctx=$(kubectl config view -o=jsonpath='{.current-context}')
    "$1_prompt_segment" "$0" "$2" "magenta" "white" "$cur_ctx" "KUBERNETES_ICON"
  fi
}

POWERLEVEL9K_GCP_PROJECT_ICON="%F{red}\ue7b2"
POWERLEVEL9K_GCP_USER_ICON="%F{027}\uf415"
POWERLEVEL9K_GCP_SERVICE_ACCOUNT_ICON="%F{red}\uf013"

# Powerlevel9k configuration

## Prompt configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX="%F{blue}\u251C\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kubecontext gcp_project gcp_user_joined newline context dir_writable dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)

## Use codepoints from nerdfont-complete (brew tap caskroom/fonts; brew cask install font-meslo-nerd-font)
POWERLEVEL9K_MODE='nerdfont-complete'

## Truncate dir path up to git repository root directory
# POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_folder_marker
# POWERLEVEL9K_SHORTEN_FOLDER_MARKER=.git


# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# gitfast: Faster git completions
# sudo: ESC twice: Puts sudo in front of the current command

plugins=(
  gitfast
  sudo
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Node version manager
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Z
. /usr/local/etc/profile.d/z.sh

# Add $HOME/bin
export PATH="$HOME/bin:$HOME/development/personal/dotfiles/bin:$HOME/development/tapad/gcp-integration/gcp-utils/src/main/bash:/usr/local/opt/scala@2.11/bin:$PATH"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup pyenv
export PATH=$(pyenv root)/shims:$PATH

## Don't let brew know about pyenv
alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'

# Setup virtualenv home
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

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
alias ls="ls -G"
alias stripcolors='sed -E "s/[[:cntrl:]]\[[0-9]{1,3}m//g"'
#alias ls='(ls | say &);ls'


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
    if ! [[ "$1" =~ "(^ykchalresp |^ |password|PASSWORD)" ]] ; then
        print -Sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
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
if [ -f '/Users/josteingogstad/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/josteingogstad/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/josteingogstad/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/josteingogstad/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
