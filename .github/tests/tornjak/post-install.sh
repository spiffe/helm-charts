#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

k_wait=(kubectl wait --for condition=available --timeout 30s --namespace)
k_rollout_status=(kubectl rollout status --watch --timeout 30s --namespace)

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
| spire-server                         | "$("${k_rollout_status[@]}" spire-server statefulset spire-server)" |
| tornjak-frontend                     | "$("${k_wait[@]}" spire-server deployments.apps spire-tornjak-frontend)" |
| tornjak-frontend                     | "$("${k_rollout_status[@]}" spire-server deployments.apps spire-tornjak-frontend)" |
EOF

kubectl -n spire-server get service spire-tornjak-frontend

if [ $1 -ne 0 ]; then
  get_namespace_details spire-server
  get_namespace_details spire-system
fi
fi
