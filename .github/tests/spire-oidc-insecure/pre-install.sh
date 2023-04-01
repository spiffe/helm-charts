#!/usr/bin/env bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

source "$SCRIPTPATH/../repos.sh"
source "$SCRIPTPATH/../versions.sh"

helm install ingress-nginx ingress-nginx --version "$VERSION_INGRESS_NGINX" --repo "$HELM_REPO_INGRESS_NGINX" -n "$scenario" --set controller.extraArgs.enable-ssl-passthrough=
kubectl wait --namespace ingress-nginx   --for=condition=ready pod   --selector=app.kubernetes.io/component=controller -n "$scenario"
