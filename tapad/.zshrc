# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jostein.gogstad/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

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
plugins=(git zsh-autosuggestions docker)

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

export DEFAULT_USER=jostein.gogstad

alias java7='export JAVA_HOME=$JAVA7_HOME'
alias java8='export JAVA_HOME=$JAVA8_HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.hadoopsetup ] && source ~/.hadoopsetup
#
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

shared_bash=/Users/jostein.gogstad/development/tapad/gcp-integration/gcp-utils/src/main/bash
export PATH="$HOME/bin:$shared_bash:/usr/local/opt/protobuf@2.5/bin:$PATH"

. ~/opt/z.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jostein.gogstad/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jostein.gogstad/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jostein.gogstad/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jostein.gogstad/opt/google-cloud-sdk/completion.zsh.inc'; fi

source '/Users/jostein.gogstad/.helm_completion'

export PYENV_ROOT="${HOME}/.pyenv"

# Configure pyenv
if [ -d "${PYENV_ROOT}" ]; then export PATH="${PYENV_ROOT}/bin:${PATH}" && eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Color config
export LESS=-r
alias jq="jq -C"
alias grep="grep --color=always"
alias ls="ls -G"
alias stripcolors='sed -E "s/[[:cntrl:]]\[[0-9]{1,3}m//g"'
#alias ls='(ls | say &);ls'
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

alias mart=kubecluster

bindkey \^U backward-kill-line
