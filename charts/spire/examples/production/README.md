# Recommended production setup

> **Note**: You should use all these files from your particular helm chart release. Don't use directly from the upstream
github repo. See the main README.md for details.

First, edit your-values.yaml and update for your deployment.

If your using CI/CD (you should), then:
 * Copy your-values.yaml into your repo
 * Also copy spire/profiles/production-values.yaml in as production-values.yaml. Don't edit it.
 * When upgrading, update your production-values.yaml from spire/profiles/production-values.yaml 

To install Spire with the least privileges possible we deploy spire across 2 namespaces.

```shell
kubectl create namespace "spire-system"
kubectl label namespace "spire-system" pod-security.kubernetes.io/enforce=privileged
kubectl create namespace "spire-server"
kubectl label namespace "spire-server" pod-security.kubernetes.io/enforce=restricted

helm upgrade --install --namespace spire-server spire charts/spire -f production-values.yaml -f your-values.yaml
```

See the charts README.md for more options to add to your-values.yaml
