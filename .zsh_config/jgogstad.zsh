alias vim=nvim
alias grep="grep --color=always"
alias stripcolors='sed -E "s/[[:cntrl:]]\[[0-9]{1,3}m//g"'
unalias ls # OMZ aliases ls to `ls -G`, put exa on path as `ls` instead

# Make Ctrl+U behave like in bash (remove from cursor until beginning of prompt)
bindkey \^U backward-kill-line

## Enable sharing of history across multiple sessions
setopt inc_append_history
setopt share_history

HISTORY_EXCLUDE_PATTERN="^ykchalresp|$HISTORY_EXCLUDE_PATTERN"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

# Update PATH
export PATH="$HOME/bin:$PATH"
