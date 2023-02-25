# spire-agent

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.4](https://img.shields.io/badge/AppVersion-1.5.4-informational?style=flat-square)

A Helm chart to install the SPIRE agent.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agentSocketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | Override where the agent looks for the socket. Only used if socketMacroName is unchanged. |
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterName | string | `"example-cluster"` |  |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9980` | override the host port used for health checking |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spire-agent"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| logLevel | string | `"info"` |  |
| nameOverride | string | `""` |  |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| server.port | int | `8081` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.port | int | `9988` |  |
| trustDomain | string | `"example.org"` |  |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` |  |
| waitForIt.image.registry | string | `"cgr.dev"` |  |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` |  |
| waitForIt.image.version | string | `"latest-20230113"` |  |
| waitForIt.resources | object | `{}` |  |
| workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |

----------------------------------------------
