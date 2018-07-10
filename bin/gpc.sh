#!/bin/bash -e
function error {
  echo "$@" >&2 && exit 1
}

[[ -z "$1" ]] && error "Usage: $0 <project-name>"

echo "Querying for default GKE cluster"
PROJECT="$1"
OLD_IFS="$IFS"
IFS=$'\n'
clusters=($(gcloud --project "$PROJECT" container clusters list --filter='resourceLabels.tapad-gke-environment=current AND resourceLabels.tapad-gke-cluster=default' | grep RUNNING))
IFS="$OLD_IFS"

[[ ${#clusters[@]} -ne 1 ]] && error "Expected to find 1 cluster, but got ${#clusters[@]}"

cluster_name=$(cut -d ' ' -f1 <<<"${clusters[@]}")
cluster_zone=$(cut -d ' ' -f3 <<<"${clusters[@]}")

echo "gcloud container clusters get-credentials --zone ${cluster_zone} ${cluster_name}"
gcloud container clusters get-credentials --zone "${cluster_zone}" "${cluster_name}" --project "$PROJECT"
gcloud config set project "$PROJECT"
