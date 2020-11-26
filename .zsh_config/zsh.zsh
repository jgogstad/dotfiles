setopt inc_append_history   # Write to history file immediately, not when shell exits
setopt share_history        # Share history between all sessions
setopt hist_no_store        # Don't store history commands

bindkey '^[[1;9D' backward-word # ⌥←
bindkey '^[[1;9C' forward-word  # ⌥→
