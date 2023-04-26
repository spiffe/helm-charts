#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
scenario="${scenario:-$(basename "${SCRIPTPATH}")}"

k_wait () {
  kubectl wait --for condition=available --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

k_rollout_status () {
  kubectl rollout status --watch --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

RELEASE=$(helm ls --no-headers -n "${scenario}" | awk '{print $1}' | grep 'spire-[^-]*$')

cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### release
| release |
| ------- |
| $RELEASE |

### spire
| workload | Status |
| -------- | ------ |
| spire-server | <pre>$(k_rollout_status spire-server statefulset "${RELEASE}-server")</pre> |
| spire-spiffe-csi-driver | <pre>$(k_rollout_status spire-system daemonset "${RELEASE}-spiffe-csi-driver")</pre> |
| spire-agent | <pre>$(k_rollout_status spire-system daemonset "${RELEASE}-agent")</pre> |
| spire-spiffe-oidc-discovery-provider | <pre>$(k_wait spire-server deployments.apps "${RELEASE}-spiffe-oidc-discovery-provider")</pre> |
EOF

if [[ "$1" -ne 0 ]]; then
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
  kubectl get pods -o name -n spire-server | while read -r line; do echo logs for "${line}"; kubectl logs -n spire-server "${line}"--all-containers=true --ignore-errors=true; done
  kubectl get pods -o name -n spire-system | while read -r line; do echo logs for "${line}"; kubectl logs -n spire-system "${line}" --all-containers=true --ignore-errors=true; done
  echo '========================================================================================================================'
  echo '```'
fi | cat >> "$GITHUB_STEP_SUMMARY"
