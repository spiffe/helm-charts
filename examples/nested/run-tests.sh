#!/usr/bin/env bash

set -xe

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
TESTDIR="${SCRIPTPATH}/../../.github/tests"
DEPS="${TESTDIR}/dependencies"

# shellcheck source=/dev/null
source "${SCRIPTPATH}/../../.github/scripts/parse-versions.sh"
# shellcheck source=/dev/null
source "${TESTDIR}/common.sh"

helm_install=(helm upgrade --install --create-namespace)
ns=spire-system

teardown() {
  helm uninstall --namespace "${ns}" spire 2>/dev/null || true
  kubectl delete ns "${ns}" 2>/dev/null || true

  helm uninstall --namespace mysql mysql 2>/dev/null || true
  kubectl delete ns mysql 2>/dev/null || true
}

trap 'trap - SIGTERM && teardown' SIGINT SIGTERM EXIT

"${helm_install[@]}" spire charts/spire \
  --namespace spire-root-server \
  --values "${DEPS}/spire-root-server-values.yaml" \
  --wait

kubectl get nodes -o go-template='{{range .items}}{{printf "%s\n" .metadata.uid}}{{end}}' | while read -r line; do
  kubectl exec -t spire-server-0 -n "spire-root-server" -- spire-server entry create -spiffeID spiffe://example.org/example-cluster/nested-spire -parentID "spiffe://example.org/spire/agent/k8s_psat/example-cluster/$line" -selector k8s:pod-label:app.kubernetes.io/name:server -downstream
done

"${helm_install[@]}" --namespace "${ns}" --values "${SCRIPTPATH}/values.yaml" \
  --wait spire charts/spire
helm test --namespace "${ns}" spire

print_helm_releases
print_spire_workload_status "${ns}"

if [[ "$1" -ne 0 ]]; then
  get_namespace_details "${ns}"
fi
