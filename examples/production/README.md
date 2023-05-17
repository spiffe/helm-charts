# Recommended production setup

To install Spire with the least privileges possible we deploy spire across 2 namespaces.

```shell
kubectl create namespace "spire-system"
kubectl label namespace "spire-system" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "spire-server"
kubectl label namespace "spire-server" pod-security.kubernetes.io/enforce=restricted

helm upgrade --install --namespace spire-server spire charts/spire -f values.yaml
```

See [values.yaml](./values.yaml) for more details on the chart configurations to achieve this setup.

If you want to expose your spire-server outside of Kubernetes and are using ingress-nginx, add following values file when running `helm template/install/upgrade`.

```shell
-f values-expose-spire-server-ingress-nginx.yaml
```

If you want to expose your federation endpoint outside of Kubernetes and are using ingress-nginx
you have two options as described here:
https://github.com/spiffe/spiffe/blob/main/standards/SPIFFE_Federation.md#52-endpoint-profiles

If you chose profile https_web, use:

```shell
-f values-expose-federation-https-web-ingress-nginx.yaml
```

If you chose profile https_spiffe, use:

```shell
-f values-expose-federation-https-spiffe-ingress-nginx.yaml
```
