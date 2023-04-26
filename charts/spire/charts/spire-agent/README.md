# spire-agent

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.3](https://img.shields.io/badge/AppVersion-1.6.3-informational?style=flat-square)

A Helm chart to install the SPIRE agent.

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bash.image.pullPolicy | string | `"Always"` |  |
| bash.image.registry | string | `"cgr.dev"` |  |
| bash.image.repository | string | `"chainguard/bash"` |  |
| bash.image.version | string | `"latest"` |  |
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterName | string | `"example-cluster"` |  |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fsGroupFix.resources | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9980` | override the host port used for health checking |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spire-agent"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| logLevel | string | `"info"` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| server.address | string | `""` |  |
| server.namespaceOverride | string | `""` |  |
| server.port | int | `8081` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| socketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` |  |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-agent |
| telemetry.prometheus.port | int | `9988` |  |
| trustDomain | string | `"example.org"` |  |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` |  |
| waitForIt.image.registry | string | `"cgr.dev"` |  |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` |  |
| waitForIt.image.version | string | `"latest-20230113"` |  |
| waitForIt.resources | object | `{}` |  |
| workloadAttestors.k8s.skipKubeletVerification | bool | `true` | If true, kubelet certificate verification is skipped |
| workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |

----------------------------------------------
