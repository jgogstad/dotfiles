alias vim=nvim
alias kctx=kubectx
alias kc=kubectx
alias k=kubectl

function lsd { exa --color=never -d $PWD/$1}

# https://github.com/jgogstad/passwordless-history
# Exclude yubikey secrets and kubectx context assignments from history
HISTORY_EXCLUDE_PATTERN="^ykchalresp|^kc .*=\.|$HISTORY_EXCLUDE_PATTERN"

# Google Cloud Platform
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

## gcloud crashes on python 3.9
export CLOUDSDK_PYTHON=python2

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

# Load z
. /usr/local/etc/profile.d/z.sh

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Homebrew settings
export HOMEBREW_CASK_OPTS="--require-sha --greedy --no-quarantine"
