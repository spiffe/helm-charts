# spire-server

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.0](https://img.shields.io/badge/AppVersion-1.7.0-informational?style=flat-square)

A Helm chart to install the SPIRE server.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.
>
> The recommended spire-controller-manager version is `0.2.2` to support arm64 nodes. If running with any
> prior version to `0.2.2` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |
| kfox1111 | <Kevin.Fox@pnnl.gov> |  |
| faisal-memon | <fymemon@yahoo.com> |  |
| edwbuck | <edwbuck@gmail.com> |  |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| bundleConfigMap | string | `"spire-bundle"` |  |
| caKeyType | string | `"rsa-2048"` | The CA key type to use, possible values are rsa-2048, rsa-4096, ec-p256, ec-p384 (AWS requires the use of RSA.  EC cryptography is not supported) |
| caTTL | string | `"24h"` |  |
| ca_subject.common_name | string | `"example.org"` |  |
| ca_subject.country | string | `"NL"` |  |
| ca_subject.organization | string | `"Example"` |  |
| clusterDomain | string | `"cluster.local"` |  |
| clusterName | string | `"example-cluster"` |  |
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Server ConfigMap |
| controllerManager.configMap.annotations | object | `{}` | Annotations to add to the Controller Manager ConfigMap |
| controllerManager.enabled | bool | `false` |  |
| controllerManager.identities.dnsNameTemplates | list | `[]` |  |
| controllerManager.identities.enabled | bool | `true` |  |
| controllerManager.identities.federatesWith | list | `[]` |  |
| controllerManager.identities.namespaceSelector | object | `{}` |  |
| controllerManager.identities.podSelector | object | `{}` |  |
| controllerManager.identities.spiffeIDTemplate | string | `"spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"` |  |
| controllerManager.ignoreNamespaces[0] | string | `"kube-system"` |  |
| controllerManager.ignoreNamespaces[1] | string | `"kube-public"` |  |
| controllerManager.ignoreNamespaces[2] | string | `"local-path-storage"` |  |
| controllerManager.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| controllerManager.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| controllerManager.image.repository | string | `"spiffe/spire-controller-manager"` | The repository within the registry |
| controllerManager.image.tag | string | `"0.2.3"` | Overrides the image tag |
| controllerManager.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| controllerManager.resources | object | `{}` |  |
| controllerManager.securityContext | object | `{}` |  |
| controllerManager.service.annotations | object | `{}` |  |
| controllerManager.service.port | int | `443` |  |
| controllerManager.service.type | string | `"ClusterIP"` |  |
| controllerManager.validatingWebhookConfiguration.failurePolicy | string | `"Fail"` |  |
| dataStore.sql.databaseName | string | `"spire"` | Only used by "postgres" or "mysql" |
| dataStore.sql.databaseType | string | `"sqlite3"` | Other supported databases are "postgres" and "mysql" |
| dataStore.sql.host | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.options | list | `[]` | Only used by "postgres" or "mysql" |
| dataStore.sql.password | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.plugin_data | object | `{}` | Settings from https://github.com/spiffe/spire/blob/main/doc/plugin_server_datastore_sql.md go in this section |
| dataStore.sql.port | int | `0` | If 0 (default), it will auto set to 5432 for postgres and 3306 for mysql. Only used by those databases. |
| dataStore.sql.username | string | `"spire"` | Only used by "postgres" or "mysql" |
| defaultJwtSvidTTL | string | `"1h"` |  |
| defaultX509SvidTTL | string | `"4h"` |  |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| federation.bundleEndpoint.address | string | `"0.0.0.0"` |  |
| federation.bundleEndpoint.port | int | `8443` |  |
| federation.enabled | bool | `false` |  |
| federation.ingress.annotations | object | `{}` |  |
| federation.ingress.className | string | `""` |  |
| federation.ingress.enabled | bool | `false` |  |
| federation.ingress.hosts[0].host | string | `"spire-server-federation.example.org"` |  |
| federation.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| federation.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| federation.ingress.tls | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-server"` | The repository within the registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"spire-server.example.org"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| jwtIssuer | string | `"oidc-discovery.example.org"` | The JWT issuer domain |
| livenessProbe.failureThreshold | int | `2` | Failure threshold count for livenessProbe |
| livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| livenessProbe.timeoutSeconds | int | `3` | Timeout in seconds for livenessProbe |
| logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeAttestor.k8sPsat.enabled | bool | `true` |  |
| nodeAttestor.k8sPsat.serviceAccountAllowList | list | `[]` |  |
| nodeSelector | object | `{}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| notifier.k8sbundle.namespace | string | `""` | Namespace to push the bundle into, if blank will default to SPIRE Server namespace |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClass | string | `nil` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| replicaCount | int | `1` | SPIRE server currently runs with a sqlite database. Scaling to multiple instances will not work until we use an external database. |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8081` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-server |
| tolerations | list | `[]` |  |
| tools.kubectl.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| tools.kubectl.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| tools.kubectl.image.repository | string | `"rancher/kubectl"` | The repository within the registry |
| tools.kubectl.image.tag | string | `""` | Overrides the image tag |
| tools.kubectl.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| topologySpreadConstraints | list | `[]` |  |
| tornjak.config.dataStore | object | `{"driver":"sqlite3","file":"/run/spire/data/tornjak.sqlite3"}` | Persistent DB for storing Tornjak specific information |
| tornjak.config.http.enabled | bool | `true` | Enables Tornjak HTTP (insecure) service |
| tornjak.config.http.port | int | `10000` | Container port value for HTTP |
| tornjak.config.http.service | object | `{"annotations":{},"port":10000,"type":"ClusterIP"}` | Service to handle Tornjak HTTP connection |
| tornjak.config.mtls.enabled | bool | `true` | Enables Tornjak TLS service |
| tornjak.config.mtls.port | int | `30000` | Container port value for mTLS |
| tornjak.config.mtls.service | object | `{"annotations":{},"port":30000,"type":"ClusterIP"}` | Service to handle Tornjak mTLS connection |
| tornjak.config.tls.enabled | bool | `true` | Enables Tornjak TLS service |
| tornjak.config.tls.port | int | `20000` | Container port value for TLS |
| tornjak.config.tls.service | object | `{"annotations":{},"port":20000,"type":"ClusterIP"}` | Service to handle Tornjak TLS connection |
| tornjak.enabled | bool | `false` | Deploys Tornjak API (backend) (Not for production) |
| tornjak.image.pullPolicy | string | `"IfNotPresent"` | The Tornjak image pull policy |
| tornjak.image.registry | string | `"ghcr.io"` | The OCI registry to pull the Tornjak image from |
| tornjak.image.repository | string | `"spiffe/tornjak-backend"` | The repository within the registry |
| tornjak.image.tag | string | `"v1.2.2"` | Overrides the image tag |
| tornjak.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tornjak.resources | object | `{}` |  |
| tornjak.startupProbe.failureThreshold | int | `3` |  |
| tornjak.startupProbe.initialDelaySeconds | int | `5` | Initial delay seconds for |
| tornjak.startupProbe.periodSeconds | int | `10` |  |
| tornjak.startupProbe.successThreshold | int | `1` |  |
| tornjak.startupProbe.timeoutSeconds | int | `5` |  |
| trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| upstreamAuthority.certManager.ca.create | bool | `false` | Creates a Cert-Manager CA |
| upstreamAuthority.certManager.ca.duration | string | `"87600h"` | Duration of the CA. Defaults to 10 years. |
| upstreamAuthority.certManager.ca.privateKey.algorithm | string | `"ECDSA"` |  |
| upstreamAuthority.certManager.ca.privateKey.rotationPolicy | string | `""` |  |
| upstreamAuthority.certManager.ca.privateKey.size | int | `256` |  |
| upstreamAuthority.certManager.ca.renewBefore | string | `""` | How long to wait before renewing the CA |
| upstreamAuthority.certManager.enabled | bool | `false` |  |
| upstreamAuthority.certManager.issuer_group | string | `"cert-manager.io"` |  |
| upstreamAuthority.certManager.issuer_kind | string | `"Issuer"` |  |
| upstreamAuthority.certManager.issuer_name | string | `""` | Defaults to the release name, override if CA is provided outside of the chart |
| upstreamAuthority.certManager.kube_config_file | string | `""` |  |
| upstreamAuthority.certManager.namespace | string | `""` | Specify to use a namespace other then the one the chart is installed into |
| upstreamAuthority.certManager.rbac.create | bool | `true` |  |
| upstreamAuthority.disk.enabled | bool | `false` |  |
| upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |
| upstreamAuthority.spire.enabled | bool | `false` |  |
| upstreamAuthority.spire.server.address | string | `""` |  |
| upstreamAuthority.spire.server.port | int | `8081` |  |

----------------------------------------------
