# spiffe-oidc-discovery-provider

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.1](https://img.shields.io/badge/AppVersion-1.7.1-informational?style=flat-square)

A Helm chart to install the SPIFFE OIDC discovery provider.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

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
| agentSocketName | string | `"spire-agent.sock"` | The name of the spire-agent unix socket |
| annotations | object | `{}` | Annotations for the deployment |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| clusterDomain | string | `"cluster.local"` |  |
| config.acme.cacheDir | string | `"/run/spire"` |  |
| config.acme.directoryUrl | string | `"https://acme-v02.api.letsencrypt.org/directory"` |  |
| config.acme.emailAddress | string | `"letsencrypt@example.org"` |  |
| config.acme.tosAccepted | bool | `false` |  |
| config.additionalDomains | list | `["localhost"]` | Add additional domains that can be used for oidc discovery |
| config.logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| configMap.annotations | object | `{}` | Annotations to add to the SPIFFE OIDC Discovery Provider ConfigMap |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/oidc-discovery-provider"` | The repository within the registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"oidc-discovery.example.org"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| insecureScheme.enabled | bool | `false` |  |
| insecureScheme.nginx.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| insecureScheme.nginx.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| insecureScheme.nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` | The repository within the registry |
| insecureScheme.nginx.image.tag | string | `"1.24.0-alpine"` | Overrides the image tag |
| insecureScheme.nginx.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| insecureScheme.nginx.resources | object | `{}` |  |
| jwtIssuer | string | `"https://oidc-discovery.example.org"` |  |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `5` | Period seconds for livenessProbe |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.nginxExporter.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| telemetry.prometheus.nginxExporter.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| telemetry.prometheus.nginxExporter.image.repository | string | `"nginx/nginx-prometheus-exporter"` | The repository within the registry |
| telemetry.prometheus.nginxExporter.image.tag | string | `"0.11.0"` | Overrides the image tag |
| telemetry.prometheus.nginxExporter.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| telemetry.prometheus.nginxExporter.resources | object | `{}` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spiffe-oidc-discovery-provider |
| telemetry.prometheus.port | int | `9988` |  |
| tolerations | list | `[]` |  |
| tools.kubectl.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| tools.kubectl.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| tools.kubectl.image.repository | string | `"rancher/kubectl"` | The repository within the registry |
| tools.kubectl.image.tag | string | `""` | Overrides the image tag |
| tools.kubectl.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |

----------------------------------------------
