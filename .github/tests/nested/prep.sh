#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
kubectl create namespace "${VALUES}-deps"
helm install -n "${VALUES}-deps" spire charts/spire --wait -f $SCRIPT_DIR/deps-values.yaml
kubectl get all -n "${VALUES}-deps"
while true; do
	bundle=$(kubectl get configmap spire-bundle -o go-template='{{ index .data "bundle.crt" }}')
	[ "x$bundle" != "x" ] && break
	sleep 1;
done
kubectl create configmap -n "$VALUES" spire-bundle-upstream --from-literal="bundle.crt=$bundle"
