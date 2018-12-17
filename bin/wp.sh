#!/bin/bash -e
function error {
  echo "$*" >&2 && exit 1
}

if [[ -n "$1" ]]; then
    kubectx "$1"
fi

function first_free_port {
    for i in {0..9}; do
        port="808$i"
        if ! lsof -nP -i4"TCP:$port" > /dev/null 2>&1; then
            echo $port
            return 0
        else
            echo "Port $port busy, checking $((port + 1))..." >&2
        fi
    done
    error "No free ports found"
}

port=$(first_free_port)

echo "Found open port $port, opening tunnel..."
webserver=$(kubectl get pods | awk '/airflow-webserver.*Running/ {print $1}')
[[ -z "$webserver" ]] && error "No running webserver found"
kubectl port-forward "$webserver" "$port:8080"
