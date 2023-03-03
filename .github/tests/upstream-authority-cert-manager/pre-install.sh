#!/bin/bash
helm install cert-manager cert-manager --namespace cert-manager --create-namespace --version v1.11.0 --set installCRDs=true --repo https://charts.jetstack.io --wait
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
kubectl apply -f $SCRIPT_DIR/cert_manager_ca.yaml -n "$VALUES"
