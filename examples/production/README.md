# Recommended production setup

To install Spire with the least privileges possible we deploy spire across 2 namespaces.

```shell
kubectl create namespace "spire-system"
kubectl label namespace "spire-system" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "spire-server"
kubectl label namespace "spire-server" pod-security.kubernetes.io/enforce=restricted

```shell
helm upgrade --install --namespace spire-server spire charts/spire -f values.yaml
```

If your using ingress-nginx and want to expose spire outside the cluster, add the
following to the end of the helm upgrade example:

```shell
-f values-export-ingress-nginx.yaml
```

See [values.yaml](./values.yaml) for more details on the chart configurations to achieve this setup.
