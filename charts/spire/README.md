# spire

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.4.4](https://img.shields.io/badge/AppVersion-1.4.4-informational?style=flat-square)

A Helm chart for deploying spire-server and spire-agent.

> :warning: Please note this chart requires Projected Service Account Tokens which has to be enabled on your k8s api server.

> :warning: Minimum Spire version is `v1.0.2`.

To enable Projected Service Account Tokens on Docker for Mac/Windows run the following
command to SSH into the Docker Desktop K8s VM.

```bash
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

Then add the following to `/etc/kubernetes/manifests/kube-apiserver.yaml`

```yaml
spec:
  containers:
    - command:
        - kube-apiserver
        - --api-audiences=api,spire-server
        - --service-account-issuer=api,spire-agent
        - --service-account-key-file=/run/config/pki/sa.pub
        - --service-account-signing-key-file=/run/config/pki/sa.key
```

**Homepage:** <https://github.com/philips-labs/helm-charts/charts/spire>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |

## Source Code

* <https://github.com/philips-labs/helm-charts/charts/spire>

## Requirements

Kubernetes: `>=1.21.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| agent.image.pullPolicy | string | `"IfNotPresent"` |  |
| agent.image.repository | string | `"gcr.io/spiffe-io/spire-agent"` |  |
| agent.image.tag | string | `""` |  |
| agent.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| agent.resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| csiDriver.image.pullPolicy | string | `"IfNotPresent"` |  |
| csiDriver.image.repository | string | `"ghcr.io/spiffe/spiffe-csi-driver"` |  |
| csiDriver.image.tag | string | `"0.2.0"` |  |
| csiDriver.resources | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| nodeDriverRegistrar.image.repository | string | `"quay.io/k8scsi/csi-node-driver-registrar"` |  |
| nodeDriverRegistrar.image.tag | string | `"v2.0.1"` |  |
| nodeDriverRegistrar.resources | object | `{}` |  |
| oidc.acme.cacheDir | string | `"/run/spire"` |  |
| oidc.acme.directoryUrl | string | `"https://acme-v02.api.letsencrypt.org/directory"` |  |
| oidc.acme.emailAddress | string | `"letsencrypt@example.org"` |  |
| oidc.acme.tosAccepted | bool | `false` |  |
| oidc.domains[0] | string | `"localhost"` |  |
| oidc.domains[1] | string | `"spire-oidc.spire"` |  |
| oidc.domains[2] | string | `"spire-oidc.spire.svc.cluster.local"` |  |
| oidc.domains[3] | string | `"oidc-discovery.example.org"` |  |
| oidc.enabled | bool | `false` |  |
| oidc.image.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.image.repository | string | `"gcr.io/spiffe-io/oidc-discovery-provider"` |  |
| oidc.image.tag | string | `""` |  |
| oidc.insecureScheme.enabled | bool | `false` |  |
| oidc.insecureScheme.nginx.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.insecureScheme.nginx.repository | string | `"nginx"` |  |
| oidc.insecureScheme.nginx.tag | string | `"alpine"` |  |
| oidc.jwtIssuer | string | `"oidc-discovery.example.org"` |  |
| oidc.logLevel | string | `"INFO"` |  |
| oidc.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| oidc.resources | object | `{}` |  |
| oidc.service.annotations | object | `{}` |  |
| oidc.service.port | int | `80` |  |
| oidc.service.type | string | `"NodePort"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| securityContext | object | `{}` |  |
| server.dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.dataStorage.enabled | bool | `true` |  |
| server.dataStorage.size | string | `"1Gi"` |  |
| server.dataStorage.storageClass | string | `nil` |  |
| server.image.pullPolicy | string | `"IfNotPresent"` |  |
| server.image.repository | string | `"gcr.io/spiffe-io/spire-server"` |  |
| server.image.tag | string | `""` |  |
| server.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| server.resources | object | `{}` |  |
| server.service.port | int | `8081` |  |
| server.service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| spire.agent.logLevel | string | `"INFO"` |  |
| spire.clusterName | string | `"example-cluster"` |  |
| spire.server.logLevel | string | `"INFO"` |  |
| spire.trustDomain | string | `"example.org"` |  |
| tolerations | list | `[]` |  |
| workloadRegistrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| workloadRegistrar.image.repository | string | `"gcr.io/spiffe-io/k8s-workload-registrar"` |  |
| workloadRegistrar.image.tag | string | `""` |  |
| workloadRegistrar.resources | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
