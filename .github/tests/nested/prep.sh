#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
helm install -n "${VALUES}-deps" charts/spire -f $SCRIPT_DIR/deps.yaml
kubectl get all -n "${VALUES}-deps"
