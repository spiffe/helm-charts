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

function get_namespace_details {
cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### Namespace $1

#### Events

\`\`\`shell
$(kubectl --request-timeout=30s get events --output wide --namespace "$1")
\`\`\`

#### Pods

\`\`\`shell
$(kubectl --request-timeout=30s describe pods --namespace "$1")
\`\`\`

#### Logs

\`\`\`shell
$(kubectl get pods -o name -n "$1" | while read -r line; do echo logs for "${line}"; kubectl logs -n "$1" "${line}" --all-containers=true --ignore-errors=true; done)
\`\`\`

EOF
}

cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### spire

| workload                             | Status |
| ------------------------------------ | ------ |
| spire-server                         | "$(k_rollout_status spire-server statefulset spire-server)" |
| spire-controller-manager             | "$(k_rollout_status spire-server statefulset spire-controller-manager)" |
| spire-spiffe-oidc-discovery-provider | "$(k_wait spire-server deployments.apps spire-spiffe-oidc-discovery-provider)" |
| spire-spiffe-csi-driver              | "$(k_rollout_status spire-system daemonset spire-spiffe-csi-driver)" |
| spire-agent                          | "$(k_rollout_status spire-system daemonset spire-agent)" |
EOF

if [[ "$1" -ne 0 ]]; then
  get_namespace_details spire-server
  get_namespace_details spire-systen
fi
