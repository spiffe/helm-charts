#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

k_wait () {
  kubectl wait --for condition=available --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

k_rollout_status () {
  kubectl rollout status --watch --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### spire
| workload | Status |
| -------- | ------ |
| spire-server | <pre>$(k_rollout_status spire-server statefulset "${RELEASE}-server")</pre> |
| spire-spiffe-csi-driver | <pre>$(k_rollout_status spire-system daemonset "${RELEASE}-spiffe-csi-driver")</pre> |
| spire-agent | <pre>$(k_rollout_status spire-system daemonset "${RELEASE}-agent")</pre> |
| spire-spiffe-oidc-discovery-provider | <pre>$(k_wait spire-server deployments.apps "${RELEASE}-spiffe-oidc-discovery-provider")</pre> |
EOF

if [ $1 -ne 0 ]; then
  for ns in spire-server spire-system ingress-nginx cert-manager; do
    echo
    echo '```'
    echo "==> Events of namespace $ns"
    echo "........................................................................................................................"
    echo ">>> kubectl --request-timeout=30s get events --output wide --namespace $ns"
    kubectl --request-timeout=30s get events --output wide --namespace $ns
    echo "........................................................................................................................"
    echo "<== Events of namespace $ns"
    echo "........................................................................................................................"
    echo ">>> kubectl --request-timeout=30s describe pods --namespace $ns"
    kubectl --request-timeout=30s describe pods --namespace $ns
    echo "========================================================================================================================"
    kubectl get pods -o name -n $ns | while read line; do echo logs for $line; kubectl logs -n $ns $line --all-containers=true --ignore-errors=true; done
    echo '========================================================================================================================'
    echo '```'
  done
fi | cat >> "$GITHUB_STEP_SUMMARY"
