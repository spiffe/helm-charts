#!/usr/bin/env bash

set -xe

helm install \
  --namespace spire-server \
  --values charts/spire/profiles/production-values.yaml \
  spire charts/spire --wait

helm test spire --namespace spire-server
