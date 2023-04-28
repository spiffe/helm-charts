#!/usr/bin/env bash

set -xe

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"

helm install \
  --namespace spire-server \
  --values charts/spire/profiles/production-values.yaml \
  spire charts/spire --wait

helm test spire --namespace spire-server
