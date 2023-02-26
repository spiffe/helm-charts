#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
kubectl create namespace "${VALUES}-deps"
helm install -n "${VALUES}-deps" spire charts/spire -f $SCRIPT_DIR/deps-values.yaml
kubectl get all -n "${VALUES}-deps"
