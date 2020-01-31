#!/bin/bash

# A custom helm launcher that:
# - Runs system helm as usual
# - Supports switching helm version with `helm switch 2.14.1`
#
# Usage:
# 
# helm current        # Show current version
# helm switch 2.14.1  # Switch to helm 2.14.1
# helm switch system  # Switch to system version of helm


sys_helm=$(which helm)
HELM_LAUNCHER_CONFIG_FILE="$HOME/.config/helm_launcher/current"

function init {
  if [[ ! -f "$HELM_LAUNCHER_CONFIG_FILE" ]]; then
    mkdir -p "$(dirname "$HELM_LAUNCHER_CONFIG_FILE")"
    echo -n "system" > "$HELM_LAUNCHER_CONFIG_FILE"
  fi
}

function helm {
  terminate=false
  case "$1" in
    "current") cat "$HELM_LAUNCHER_CONFIG_FILE"
      terminate=true
      ;;
    "switch") if [[ -n "$2" ]]; then
                echo "Switching from $(cat "$HELM_LAUNCHER_CONFIG_FILE") to $2"
                echo -n "$2" > "$HELM_LAUNCHER_CONFIG_FILE"
                if [[ "$2" != "system" ]]; then
                  docker pull alpine/helm:"$2"
                fi
              else
                echo "Please provide version number or 'system'"
              fi
      terminate=true
      ;;
  esac

  if [[ "$terminate" == false ]]; then 

    version="$(cat "$HELM_LAUNCHER_CONFIG_FILE")"
  
    if [[ "$version" == "system" ]]; then
        "$sys_helm" "$@"
    else
      docker run -it --rm \
        -v ~/.kube/config:/root/.kube/config \
        -v ~/.helm:/root/.helm alpine/helm:"$version" \
        "$@"
    fi
  fi
}

init
