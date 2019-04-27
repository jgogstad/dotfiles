alias vim=nvim
alias grep="grep --color=always"
alias kctx=kubectx
function lsd { exa --color=never -d $PWD/$1}

# Make Ctrl+U behave like in bash (remove from cursor until beginning of prompt)
bindkey \^U backward-kill-line

## Enable sharing of history across multiple sessions
setopt inc_append_history
setopt share_history

export LESS="-Xr"

HISTORY_EXCLUDE_PATTERN="^ykchalresp|$HISTORY_EXCLUDE_PATTERN"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi
