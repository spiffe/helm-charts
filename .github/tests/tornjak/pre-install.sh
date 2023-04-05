#!/usr/bin/env bash

# kubectl create namespace spire-system
# kubectl label namespace spire-system pod-security.kubernetes.io/enforce=privileged
kubectl create namespace spire-server
kubectl label namespace spire-server pod-security.kubernetes.io/enforce=restricted
kubectl create namespace tornjak-fe
