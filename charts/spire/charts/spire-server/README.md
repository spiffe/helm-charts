# spire-server

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.0](https://img.shields.io/badge/AppVersion-1.6.0-informational?style=flat-square)

A Helm chart to install the SPIRE server.

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.
>
> The recommended spire-controller-manager version is `0.2.2` to support arm64 nodes. If running with any
> prior version to `0.2.2` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| bundleConfigMap | string | `"spire-server"` |  |
| ca_subject.common_name | string | `"example.org"` |  |
| ca_subject.country | string | `"NL"` |  |
| ca_subject.organization | string | `"Example"` |  |
| clusterName | string | `"example-cluster"` |  |
| controllerManager.enabled | bool | `false` |  |
| controllerManager.identities.dnsNameTemplates | list | `[]` |  |
| controllerManager.identities.enabled | bool | `true` |  |
| controllerManager.identities.namespaceSelector | object | `{}` |  |
| controllerManager.identities.podSelector | object | `{}` |  |
| controllerManager.identities.spiffeIDTemplate | string | `"spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"` |  |
| controllerManager.ignoreNamespaces[0] | string | `"kube-system"` |  |
| controllerManager.ignoreNamespaces[1] | string | `"kube-public"` |  |
| controllerManager.ignoreNamespaces[2] | string | `"local-path-storage"` |  |
| controllerManager.image.pullPolicy | string | `"IfNotPresent"` |  |
| controllerManager.image.registry | string | `"ghcr.io"` |  |
| controllerManager.image.repository | string | `"spiffe/spire-controller-manager"` |  |
| controllerManager.image.version | string | `"0.2.2"` |  |
| controllerManager.resources | object | `{}` |  |
| controllerManager.securityContext | object | `{}` |  |
| controllerManager.service.annotations | object | `{}` |  |
| controllerManager.service.port | int | `443` |  |
| controllerManager.service.type | string | `"ClusterIP"` |  |
| dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| dataStorage.enabled | bool | `true` |  |
| dataStorage.size | string | `"1Gi"` |  |
| dataStorage.storageClass | string | `nil` |  |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spire-server"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| jwtIssuer | string | `"oidc-discovery.example.org"` |  |
| logLevel | string | `"info"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | SPIRE server currently runs with a sqlite database. Scaling to multiple instances will not work until we use an external database. |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8081` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| telemetry.prometheus.enabled | bool | `false` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| trustDomain | string | `"example.org"` |  |
| upstreamAuthority.certManager.enabled | bool | `false` |  |
| upstreamAuthority.certManager.issuer_group | string | `"cert-manager.io"` |  |
| upstreamAuthority.certManager.issuer_kind | string | `"Issuer"` |  |
| upstreamAuthority.certManager.issuer_name | string | `"spire-ca"` |  |
| upstreamAuthority.certManager.kube_config_file | string | `""` |  |
| upstreamAuthority.certManager.namespace | string | `""` | Specify to use a namespace other then the one the chart is installed into |
| upstreamAuthority.certManager.rbac.create | bool | `true` |  |
| upstreamAuthority.disk.enabled | bool | `false` |  |
| upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |

----------------------------------------------
