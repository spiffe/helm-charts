#!/usr/bin/env bash

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
scenario="${scenario:-$(basename "${SCRIPTPATH}")}"

kubectl create namespace "${scenario}-root-server"
# Install a spire root server for testing against.
helm install -n "${scenario}-root-server" spire charts/spire --wait -f "${SCRIPTPATH}/spire-root-server-values.yaml"
kubectl get all -n "${scenario}-root-server"
kubectl get nodes -o go-template='{{range .items}}{{printf "%s\n" .metadata.uid}}{{end}}' | while read -r line; do
  kubectl exec -t spire-server-0 -n "${scenario}-root-server" -- spire-server entry create -spiffeID spiffe://example.org/example-cluster/nested-spire -parentID "spiffe://example.org/spire/agent/k8s_psat/example-cluster/$line" -selector k8s:pod-label:app.kubernetes.io/name:server -downstream
done
