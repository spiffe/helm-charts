#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

k_wait=(kubectl wait --for condition=available --timeout 30s --namespace)
k_rollout_status=(kubectl rollout status --watch --timeout 30s --namespace)

cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### spire
| workload | Status |
| -------- | ------ |
| spire-server | $("${k_rollout_status[@]}" spire-server statefulset spire-server) |
| spire-spiffe-csi-driver | $("${k_rollout_status[@]}" spire-system daemonset spire-spiffe-csi-driver) |
| spire-agent | $("${k_rollout_status[@]}" spire-server daemonset spire-agent) |
| spire-spiffe-oidc-discovery-provider | $("${k_wait[@]}" spire-server deployments.apps spire-spiffe-oidc-discovery-provider) |
EOF

if [ $1 -ne 0 ]; then
  echo
  echo '```'
  echo '==> Events of namespace spire-server'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s get events --output wide --namespace spire-server'
  kubectl --request-timeout=30s get events --output wide --namespace spire-server
  echo '........................................................................................................................'
  echo '<== Events of namespace spire-server'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s describe pods --namespace spire-server'
  kubectl --request-timeout=30s describe pods --namespace spire-server
  echo '========================================================================================================================'
  echo '==> Events of namespace spire-system'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s get events --output wide --namespace spire-system'
  kubectl --request-timeout=30s get events --output wide --namespace spire-system
  echo '........................................................................................................................'
  echo '<== Events of namespace spire-system'
  echo '........................................................................................................................'
  echo '>>> kubectl --request-timeout=30s describe pods --namespace spire-system'
  kubectl --request-timeout=30s describe pods --namespace spire-system
  echo '========================================================================================================================'
  kubectl get pods -o name -n spire-server | while read line; do echo logs for $line; kubectl logs -n spire-server $line --all-containers=true --ignore-errors=true; done
  kubectl get pods -o name -n spire-system | while read line; do echo logs for $line; kubectl logs -n spire-system $line --all-containers=true --ignore-errors=true; done
  echo '========================================================================================================================'
  echo '```'
fi | cat >> "$GITHUB_STEP_SUMMARY"
