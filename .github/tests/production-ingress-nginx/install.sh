#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname "${0}")"

kubectl create namespace spire-system
kubectl label namespace spire-system pod-security.kubernetes.io/enforce=privileged
kubectl create namespace spire-server
kubectl label namespace spire-server pod-security.kubernetes.io/enforce=restricted

helm install cert-manager cert-manager --namespace cert-manager --create-namespace --version v1.11.0 --set installCRDs=true --repo https://charts.jetstack.io --wait
kubectl apply -f $SCRIPT_DIR/testcert.yaml -n spire-server

helm install ingress-nginx ingress-nginx --version 4.5.2 --repo https://kubernetes.github.io/ingress-nginx --create-namespace -n ingress-nginx --wait \
    --set controller.extraArgs.enable-ssl-passthrough=,controller.admissionWebhooks.enabled=false,controller.service.type=ClusterIP \
    --set controller.ingressClassResource.default=true

ip=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o go-template='{{ .spec.clusterIP }}')
echo $ip oidc-discovery.example.org

cat > /tmp/dummydns <<EOF
spiffe-oidc-discovery-provider:
  tests:
    hostAliases:
      - ip: "$ip"
        hostnames:
          - "oidc-discovery.example.org"
EOF

helm upgrade --install --namespace spire-server spire charts/spire -f examples/production/values.yaml -f examples/production/values-export-ingress-nginx.yaml \
    -f /tmp/dummydns --set spiffe-oidc-discovery-provider.tests.tls.customCA=tls-cert --wait
