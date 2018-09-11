#!/bin/bash -e

! [[ $(git rev-parse --abbrev-ref HEAD) == master ]] && echo "Please run from master" >&2 && exit 1

CURRENT_USER=$(git config user.email)
OLD_THRESHOLD=14 # days
OLD_REMOTE_THRESHOLD=30 # days

[[ -z "$CURRENT_USER" ]] && echo "git config user.email returned empty string" >&2 && exit 1

git fetch
git remote prune origin
echo "Deleting merged branches locally and remotely"
git branch --merged | sed -nE '/master|HEAD/! s/^[[:space:]]*//p' | xargs -I '{}' sh -c 'git br -d "{}" && git branch --remote | grep -E "/{}\$" && git push origin :"{}"'
git branch -r --merged | sed -nE '/master|HEAD/! s/^[[:space:]]*//p' | xargs -I '{}' sh -c 'git br -d "{}" && git branch --remote | grep -E "/{}\$" && git push origin :"{}"'

local_branches=($(git branch -a | sed -E 's/^ *//' | grep -Ev 'master$' | grep -Ev "^remotes"))

now_seconds=$(date +%s)
now_days=$(( now_seconds / 3600 / 24))

set +e
echo "Deleting local branches"
for b in "${local_branches[@]}"; do
  last_commit_by=$(git log --oneline --format=%ce -1 "$b")

  last_commit_timestamp_seconds=$(git log --oneline --format=%ci -1 "$b" | xargs -I '{}' date -j -f "%Y-%m-%d %T %z" "{}" +%s)
  last_commit_timestamp_days=$(( last_commit_timestamp_seconds / 3600 / 24))
  days_since=$(( now_days - last_commit_timestamp_days))

  if [[ $days_since -ge $OLD_THRESHOLD ]]; then
    if [[ "$last_commit_by" != "$CURRENT_USER" ]]; then
      echo "Ignoring old branch by different user: $b, last commit by $last_commit_by"
      continue
    fi
    echo "Deleting $b due to inactivity for $days_since days, last commit by $last_commit_by"
    git br -D "$b" && git branch --remote | grep -E "/$b\$" && git push origin :"$b"
  else
    echo "Keeping $b, $days_since days since last commit"
  fi
done

echo
echo "Deleting remote branches"
remote_branches=($(git branch --remote | sed -E 's/^ *//' | grep -Ev 'master$'))
for b in "${remote_branches[@]}"; do
  last_commit_by=$(git log --oneline --format=%ce -1 "$b")

  last_commit_timestamp_seconds=$(git log --oneline --format=%ci -1 "$b" | xargs -I '{}' date -j -f "%Y-%m-%d %T %z" "{}" +%s)
  last_commit_timestamp_days=$(( last_commit_timestamp_seconds / 3600 / 24))
  days_since=$(( now_days - last_commit_timestamp_days))

  name_without_origin=${b/origin\/}

  if [[ $days_since -ge $OLD_REMOTE_THRESHOLD ]]; then
    echo "Deleting $b due to inactivity for $days_since days, last commit by $last_commit_by"
    git push origin :"$name_without_origin"
  else
    echo "Keeping $b, $days_since days since last commit"
  fi
done
