#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

kubectl create namespace "${scenario}-root-server"
# Install a spire root server for testing against.
helm install -n "${scenario}-root-server" spire charts/spire --wait -f "${SCRIPT_DIR}/spire-root-server-values.yaml"
kubectl get all -n "${scenario}-root-server"
kubectl get nodes -o go-template='{{range .items}}{{printf "%s\n" .metadata.uid}}{{end}}' | while read line; do
  kubectl exec -t spire-server-0 -n "${scenario}-root-server" -- spire-server entry create -spiffeID spiffe://example.org/example-cluster/nested-spire -parentID spiffe://example.org/spire/agent/k8s_psat/example-cluster/$line -selector k8s:pod-label:app.kubernetes.io/name:server -downstream
done

# Install just the upstream csi driver since it can't be done in the main deployment.
helm install -n "${scenario}" spire-upstream-driver charts/spire --wait -f "${SCRIPT_DIR}/spire-upstream-driver-values.yaml"
