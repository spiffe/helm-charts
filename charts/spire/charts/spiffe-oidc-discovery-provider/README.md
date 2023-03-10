# spiffe-oidc-discovery-provider

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.0](https://img.shields.io/badge/AppVersion-1.6.0-informational?style=flat-square)

A Helm chart to install the SPIFFE OIDC discovery provider.

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| config.acme.cacheDir | string | `"/run/spire"` |  |
| config.acme.directoryUrl | string | `"https://acme-v02.api.letsencrypt.org/directory"` |  |
| config.acme.emailAddress | string | `"letsencrypt@example.org"` |  |
| config.acme.tosAccepted | bool | `false` |  |
| config.domains[0] | string | `"localhost"` |  |
| config.domains[1] | string | `"oidc-discovery.example.org"` |  |
| config.logLevel | string | `"info"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/oidc-discovery-provider"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| insecureScheme.enabled | bool | `false` |  |
| insecureScheme.nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| insecureScheme.nginx.image.registry | string | `"docker.io"` |  |
| insecureScheme.nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` |  |
| insecureScheme.nginx.image.version | string | `"1.23.2-alpine"` |  |
| insecureScheme.nginx.resources | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.nginxExporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| telemetry.prometheus.nginxExporter.image.registry | string | `"docker.io"` |  |
| telemetry.prometheus.nginxExporter.image.repository | string | `"nginx/nginx-prometheus-exporter"` |  |
| telemetry.prometheus.nginxExporter.image.version | string | `"0.11.0"` |  |
| telemetry.prometheus.nginxExporter.resources | object | `{}` |  |
| telemetry.prometheus.port | int | `9988` |  |
| tolerations | list | `[]` |  |
| trustDomain | string | `"example.org"` |  |

----------------------------------------------
