#!/bin/bash -e

function merged_branches() {
    declare -a result
    current_branch=$(git br | awk '/^\*/ {print $2}')
    for branch in $(git branch -a | sed -E 's/^ *//' | grep -Ev '^remotes' | grep -Ev 'master$' | grep -v "$current_branch"); do
      last_commit_msg="$(git log --oneline --format=%f -1 "$branch")"
      if [[ "$(git log --oneline --format=%f master | grep -c "$last_commit_msg")" -eq 1 ]]; then      
          result=("$branch" "${result[@]}")
      fi
    done
    echo "${result[@]}"
}

function delete_branches() {
    git remote prune origin
    for branch in "$@"; do
        git branch -D "$branch"
        set +e
        git push origin ":$branch"
        set -e
    done
}

delete_branches $(merged_branches)
