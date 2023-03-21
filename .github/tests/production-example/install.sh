#!/usr/bin/env bash

set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

ct install --debug \
  --namespace spire-server \
  --values "${SCRIPTPATH}/../../../examples/production/values.yaml" \
  spire charts/spire
