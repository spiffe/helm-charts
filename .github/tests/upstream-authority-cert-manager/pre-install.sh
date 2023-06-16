#!/usr/bin/env bash

SCRIPT="$(readlink -f "$0")"
SCRIPTPATH="$(dirname "${SCRIPT}")"
scenario="${scenario:-$(basename "${SCRIPTPATH}")}"

helm install cert-manager cert-manager --namespace cert-manager --create-namespace --version "$VERSION_CERT_MANAGER" --set installCRDs=true --repo "$HELM_REPO_CERT_MANAGER" --wait
