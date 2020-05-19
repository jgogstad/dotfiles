alias vim=nvim
alias grep="grep --color=always"
alias kctx=kubectx
alias kc=kubectx
alias k=kubectl
alias top='top -o cpu'

function lsd { exa --color=never -d $PWD/$1}

# -X: Don't clear terminal after less finish
# -R: Display raw color codes
# -F: Exit if the entire file can be displayed
export LESS="-RF"

# Exclude yubikey secrets and kubectx context assignments from history
HISTORY_EXCLUDE_PATTERN="^ykchalresp|^kc .*=\.|$HISTORY_EXCLUDE_PATTERN"

# Force locale
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

setopt inc_append_history   # Write to history file immediately, not when shell exits
setopt share_history        # Share history between all sessions
setopt hist_no_store        # Don't store history commands

bindkey '^[[1;9D' backward-word # ⌥←
bindkey '^[[1;9C' forward-word  # ⌥→

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/opt/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/opt/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/opt/google-cloud-sdk/completion.zsh.inc"; fi

[ -s "/Users/jostein.gogstad/.jabba/jabba.sh" ] && source "/Users/jostein.gogstad/.jabba/jabba.sh"

# Don't use outdated (Mohave) version of OpenSSL with ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export HOMEBREW_CASK_OPTS="--require-sha --greedy --no-quarantine"
