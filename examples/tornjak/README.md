# Recommended setup to deploy Tornjak

To install Spire with the least privileges possible we deploy spire across 2 namespaces.

```shell
kubectl create namespace "spire-system"
kubectl label namespace "spire-system" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "spire-server"
kubectl label namespace "spire-server" pod-security.kubernetes.io/enforce=restricted

# deploy SPIRE with Tornjak enabled
helm upgrade --install --namespace spire-server --values ../production/values.yaml \
 --values ./values.yaml spire charts/spire

# test the Tornjak deployment
helm test spire -n spire-server
```

See [values.yaml](./values.yaml) for more details on the chart configurations to achieve this setup.
