#!/bin/bash
kubectl label namespace "$scenario" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "${scenario}-deps"
kubectl label namespace "${scenario}-deps" pod-security.kubernetes.io/enforce=restricted
helm install -n "${scenario}-deps" spire charts/spire -f "${TEST_DIR}"/deps-values.yaml
