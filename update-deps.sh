#!/bin/bash

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"

for chart in spiffe-csi-driver spiffe-oidc-discovery-provider spire-agent spire-server spire; do
  pushd "${SCRIPTPATH}/charts/${chart}" || exit 1
  helm dep up
  popd || exit 1
done
