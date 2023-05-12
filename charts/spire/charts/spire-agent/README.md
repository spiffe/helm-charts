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
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterName | string | `"example-cluster"` |  |
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Agent ConfigMap |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9980` | override the host port used for health checking |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-agent"` | The repository within the registry |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| logLevel | string | `"info"` | The loglevel |
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
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| socketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | The unix socket path to the spire-agent |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-agent |
| telemetry.prometheus.port | int | `9988` |  |
| trustBundleFormat | string | `"pem"` | If using trustBundleURL, what format is the url. Choices are "pem" and "spiffe" |
| trustBundleURL | string | `""` | If set, obtain trust bundle from url instead of Kubernetes ConfigMap |
| trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| waitForIt.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` | The repository within the registry |
| waitForIt.image.version | string | `"latest-20230113"` |  |
| waitForIt.resources | object | `{}` |  |
| workloadAttestors.k8s.skipKubeletVerification | bool | `true` | If true, kubelet certificate verification is skipped |
| workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |

----------------------------------------------
