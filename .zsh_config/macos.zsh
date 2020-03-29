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
# -R: Display raw color codes
# -F: Exit if the entire file can be displayed
export LESS="-XRF"

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

# Use ruby version installed with homebrew if present. Installing gems is not possible
# with the version that ships with macOS since it lives in /Library
if [[ -d /usr/local/opt/ruby/bin ]]; then
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"
  export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi
