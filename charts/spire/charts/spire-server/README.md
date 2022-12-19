# spire-server

<!-- This README.md is generated. -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.3](https://img.shields.io/badge/AppVersion-1.5.3-informational?style=flat-square)

A Helm chart to install the SPIRE server.

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
| dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| dataStorage.enabled | bool | `true` |  |
| dataStorage.size | string | `"1Gi"` |  |
| dataStorage.storageClass | string | `nil` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spire-server"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| jwtIssuer | string | `"oidc-discovery.example.org"` |  |
| logLevel | string | `"info"` |  |
| nameOverride | string | `""` |  |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8081` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| socketPath | string | `"/run/spire/server-sockets/spire-server.sock"` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| trustDomain | string | `"example.org"` |  |
| upstreamAuthority.disk.enabled | bool | `false` |  |
| upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |
