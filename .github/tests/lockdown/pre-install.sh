#!/bin/bash
kubectl label namespace "$scenario" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "${scenario}-deps"
kubectl label namespace "${scenario}-deps" pod-security.kubernetes.io/enforce=restricted
