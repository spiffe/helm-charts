# spiffe-oidc-discovery-provider

<!-- This README.md is generated. -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.3](https://img.shields.io/badge/AppVersion-1.5.3-informational?style=flat-square)

A Helm chart to install the SPIFFE OIDC discovery provider.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| agentSocketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` |  |
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
| insecureScheme.nginx.image.repository | string | `"nginx"` |  |
| insecureScheme.nginx.image.version | string | `"1.23.2-alpine"` |  |
| insecureScheme.nginx.resources | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
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
| tolerations | list | `[]` |  |
| trustDomain | string | `"example.org"` |  |
