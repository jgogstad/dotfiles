# Load Powerlevel9k-gcp

## Prompt configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX="%F{blue}\u251C\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status gcp_project gcp_user_joined kube_context background_jobs time)

## Use codepoints from nerdfont-complete (brew tap caskroom/fonts; brew cask install font-meslo-nerd-font)
POWERLEVEL9K_MODE='nerdfont-complete'

## Truncate dir path up to git repository root directory
# POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_folder_marker
# POWERLEVEL9K_SHORTEN_FOLDER_MARKER=.git

## Context segment won't print for this user
DEFAULT_USER=$(whoami)
