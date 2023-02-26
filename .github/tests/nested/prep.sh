#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
kubectl create namespace "${VALUES}-deps"
helm install -n "${VALUES}-deps" spire charts/spire --wait -f $SCRIPT_DIR/deps-values.yaml
kubectl get all -n "${VALUES}-deps"
while true; do
	kubectl -n "${VALUES}-deps" get configmap spire-bundle -o go-template='{{ index .data "bundle.crt" }}' > bundle
	[ $? -eq 0 ] && break
	sleep 1;
done
kubectl create configmap -n "$VALUES" spire-bundle-upstream --from-file=bundle.crt=bundle
