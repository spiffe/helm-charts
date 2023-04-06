#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

helm install \
  --namespace spire-server \
  --values "${SCRIPTPATH}/../../../examples/tornjak/values.yaml" \
  spire charts/spire --wait
  helm test spire -n spire-server
