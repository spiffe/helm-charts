#!/usr/bin/env bash

set -xe

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
TESTDIR="${SCRIPTPATH}/../../.github/tests"

# shellcheck source=/dev/null
source "${TESTDIR}/common.sh"

helm_install=(helm upgrade --install --create-namespace)
ns=spire-server

teardown() {
  helm uninstall --namespace "${ns}" spire 2>/dev/null || true
  kubectl delete ns "${ns}" 2>/dev/null || true
  kubectl delete ns spire-system 2>/dev/null || true
}

trap 'trap - SIGTERM && teardown' SIGINT SIGTERM EXIT

kubectl create namespace spire-system 2>/dev/null || true
kubectl label namespace spire-system pod-security.kubernetes.io/enforce=privileged || true
kubectl create namespace "${ns}" 2>/dev/null || true
kubectl label namespace "${ns}" pod-security.kubernetes.io/enforce=restricted || true

"${helm_install[@]}" --namespace "${ns}" --values "${SCRIPTPATH}/values.yaml" --wait spire charts/spire
helm test --namespace "${ns}" spire

print_helm_releases
print_spire_workload_status "${ns}"

if [[ "$1" -ne 0 ]]; then
  get_namespace_details "${ns}"
fi
