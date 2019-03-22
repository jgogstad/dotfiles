## Powerlevel9k configuration


function gcloud_config_value {
  # gcloud cli is too slow, access file directly
  local active=$(<~/.config/gcloud/active_config)
  local config="$HOME/.config/gcloud/configurations/config_$active"
  sed -nE "/$1/ s/.*$1 = ([^ ]+).*/\1/p" < $config
}

function prompt_gcp_project {
  local project=$(gcloud_config_value project)
  $1_prompt_segment "$0" "$2" white black "$project" "GCP_PROJECT_ICON"
}

function prompt_gcp_user {
  if [[ -n "$GOOGLE_APPLICATION_CREDENTIALS" ]]; then
    local username=$(sed -nE '/email/ s/.*email": "([^"]+)".*/\1/p' < "$GOOGLE_APPLICATION_CREDENTIALS")
    if [[ -z $username ]]; then
      username="invalid"
    fi
  else
    local username=$(gcloud_config_value account)
  fi

  local icon

  if [[ $username == *"iam.gserviceaccount.com" ]]; then
    icon=GCP_SERVICE_ACCOUNT_ICON
  else
    icon=GCP_USER_ICON
  fi

  $1_prompt_segment "$0" "$2" white black "${username%.iam.gserviceaccount.com*}" "$icon"
}

function prompt_kube_context {
  local kubectl_version="$(kubectl version --client 2>/dev/null)"

  if [[ -n "$kubectl_version" ]]; then
    # Get the current Kuberenetes context
    local cur_ctx=$(kubectl config view -o=jsonpath='{.current-context}')
    "$1_prompt_segment" "$0" "$2" "magenta" "white" "$cur_ctx" "KUBERNETES_ICON"
  fi
}


## Prompt configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX="%F{blue}\u251C\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status gcp_project gcp_user_joined kube_context background_jobs time)

## GCP config
POWERLEVEL9K_GCP_PROJECT_ICON="%F{202}\ue7b2"
POWERLEVEL9K_GCP_USER_ICON="%F{027}\uf415"
POWERLEVEL9K_GCP_SERVICE_ACCOUNT_ICON="%F{red}\uf013"

## Use codepoints from nerdfont-complete (brew tap caskroom/fonts; brew cask install font-meslo-nerd-font)
POWERLEVEL9K_MODE='nerdfont-complete'

## Truncate dir path up to git repository root directory
# POWERLEVEL9K_SHORTEN_STRATEGY=truncate_with_folder_marker
# POWERLEVEL9K_SHORTEN_FOLDER_MARKER=.git

## Context segment won't print for this user
DEFAULT_USER=$(whoami)
