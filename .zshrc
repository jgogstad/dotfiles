# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

DEFAULT_USER=josteingogstad
# Path to your oh-my-zsh installation.
export ZSH=/Users/$DEFAULT_USER/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

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
# DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(
  git
  zsh-autosuggestions
  docker
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

alias java7='export JAVA_HOME=$JAVA7_HOME'
alias java8='export JAVA_HOME=$JAVA8_HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.hadoopsetup ] && source ~/.hadoopsetup
#
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

shared_bash=/Users/jostein.gogstad/development/tapad/gcp-integration/gcp-utils/src/main/bash
export PATH="$HOME/bin:$shared_bash:/usr/local/opt/protobuf@2.5/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jostein.gogstad/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jostein.gogstad/opt/google-cloud-sdk/completion.zsh.inc'; fi

source '$HOME/.helm_completion'

export PYENV_ROOT="${HOME}/.pyenv"

# Configure pyenv
if [ -d "${PYENV_ROOT}" ]; then export PATH="${PYENV_ROOT}/bin:${PATH}" && eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PIP_INDEX_URL=https://$NEXUSUSER:$NEXUSPW@nexus.tapad.com/repository/pypi/simple

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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


NEXUSUSER=$(grep "^\s*user=" < ~/.ivy2/.credentials | sed 's/.*=//g')
NEXUSPW=$(grep "^\s*password=" < ~/.ivy2/.credentials | sed 's/.*=//g')

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_GITHUB_API=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# ZSH
setopt histignorespace

# Make Ctrl+U behave like in bash (remove from cursor until beginning of prompt)
bindkey \^U backward-kill-line

function zshaddhistory() {
    emulate -L zsh
    if ! [[ "$1" =~ "(^ykchalresp |^ |password|PASSWORD)" ]] ; then
        print -sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
  }
