#!/usr/bin/env bash

get_namespace_details () {
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

k_wait () {
  kubectl wait --for condition=available --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

k_rollout_status () {
  kubectl rollout status --watch --timeout 30s --namespace "$1" "$2" "$3" | tail -n 1
}

get_spire_release_name () {
  helm ls -A | grep '^spire' | awk '{print $1}'
}

print_spire_workload_status () {
  local ns1
  local ns2

  ns1="$1"
  ns2="${2:-$1}"

  release_name="$(get_spire_release_name)"

  cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### Spire

| Namespace | Workload                                       | Status |
| --------- | ---------------------------------------------- | ------ |
| ${ns1}    | ${release_name}-server                         | <pre>$(k_rollout_status "${ns1}" statefulset "${release_name}-server")</pre> |
| ${ns2}    | ${release_name}-spiffe-csi-driver              | <pre>$(k_rollout_status "${ns2}" daemonset "${release_name}-spiffe-csi-driver")</pre> |
| ${ns2}    | ${release_name}-agent                          | <pre>$(k_rollout_status "${ns2}" daemonset "${release_name}-agent")</pre> |
| ${ns1}    | ${release_name}-spiffe-oidc-discovery-provider | <pre>$(k_rollout_status "${ns1}" deployments.apps "${release_name}-spiffe-oidc-discovery-provider")</pre> |

EOF
}

print_helm_releases () {
  cat <<EOF >>"$GITHUB_STEP_SUMMARY"
### Releases

$(helm ls -A | sed 's/\t/ | /g' | sed 's/^/| /' | sed 's/$/ |/' | sed '/^| NAME.*/a| - | - | - | - | - | - | - |')

EOF
}
