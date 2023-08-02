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

"${helm_install[@]}" mysql mysql --version "$VERSION_MYSQL" --repo "$HELM_REPO_MYSQL" \
  --namespace mysql \
  --values "${DEPS}/mysql.yaml" \
  --wait

"${helm_install[@]}" --namespace "${ns}" --values "${SCRIPTPATH}/values.yaml" \
  --set 'spire-server.dataStore.sql.password=sp1ff3Test' --wait spire charts/spire
helm test --namespace "${ns}" spire

print_helm_releases
print_spire_workload_status "${ns}"

if [[ "$1" -ne 0 ]]; then
  get_namespace_details "${ns}"
fi
