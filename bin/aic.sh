#!/bin/bash -e
function error {
  echo "$*" >&2 && exit 1
}

[[ -z "$1" ]] && error "Usage: $0 <project-name> [environment]"

PROJECT="$1"
AIRFLOW_CLUSTER_NAME="$2"

if [[ -z "$AIRFLOW_CLUSTER_NAME" ]]; then
  DEFAULT_ENVIRONMENTS=$(gcloud beta composer environments list --filter='labels.tapad-composer-environment=current AND labels.tapad-composer-cluster=default' --project "$PROJECT" --format json)
  
  ENV_COUNT=$(jq '. | length' <<< "$DEFAULT_ENVIRONMENTS")
  
  if [[ "$ENV_COUNT" -ne 1 ]]; then 
      echo "Expected exactly one environment to match labels, but found $ENV_COUNT. Fallback to naming standard"
      AIRFLOW_CLUSTER_NAME="${PROJECT/tapad-mart-}"-airflow
  else
      echo "Using cluster labelled as default"
      AIRFLOW_CLUSTER_NAME=$( (jq -cMr '.[0].name' <<< "$DEFAULT_ENVIRONMENTS") | sed -nE 's_^.*environments/([^"/]+)_\1_p')
  fi
else
  echo "Not looking up default cluster"
fi

echo "Querying GKE cluster from Airflow cluster $AIRFLOW_CLUSTER_NAME"
GKE_CLUSTER="$(gcloud beta composer environments describe "$AIRFLOW_CLUSTER_NAME" --project "$PROJECT" --format json | jq -cM '.config.gkeCluster')"

[[ -z "${GKE_CLUSTER}" ]] && error "Couldn't find GKE cluster for airflow environment ${AIRFLOW_CLUSTER_NAME} in project ${PROJECT}"

cluster_name="$(sed -nE 's_.*clusters/([^/\"]+).*_\1_p' <<< "$GKE_CLUSTER")"
cluster_zone="$(sed -nE 's_.*zones/([^/]+).*_\1_p' <<< "$GKE_CLUSTER")"

echo "gcloud container clusters get-credentials --zone ${cluster_zone} ${cluster_name} --project $PROJECT"
gcloud container clusters get-credentials --zone "${cluster_zone}" "${cluster_name}" --project "$PROJECT"
gcloud config set project "$PROJECT"
