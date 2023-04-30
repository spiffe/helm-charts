#!/bin/bash

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"

for chart in spiffe-csi-driver spiffe-oidc-discovery-provider spire-agent spire-server spire; do
  pushd "charts/${chart}"
  helm dep up
  popd
done
