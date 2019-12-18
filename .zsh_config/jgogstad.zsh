alias vim=nvim
alias grep="grep --color=always"
alias kctx=kubectx
alias kc=kubectx
alias k=kubectl
alias v=vault
alias top='top -o cpu'
alias sbt=/usr/local/bin/sbtx

function lsd { exa --color=never -d $PWD/$1}

# -X: Don't clear terminal after less finish
# -r: Display raw color codes
export LESS="-Xr"

HISTORY_EXCLUDE_PATTERN="^ykchalresp|^kc .*=\.|$HISTORY_EXCLUDE_PATTERN"

# Force locale
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# Share history across concurrently running sessions
setopt inc_append_history
setopt share_history

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi
