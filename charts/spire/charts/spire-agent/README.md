# spire-agent

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.1](https://img.shields.io/badge/AppVersion-1.7.1-informational?style=flat-square)

A Helm chart to install the SPIRE agent.

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
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterName | string | `"example-cluster"` |  |
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Agent ConfigMap |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fsGroupFix.image.pullPolicy | string | `"Always"` | The image pull policy |
| fsGroupFix.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| fsGroupFix.image.repository | string | `"chainguard/bash"` | The repository within the registry |
| fsGroupFix.image.tag | string | `"latest@sha256:96ab1600d945b4a99c8610b5c8b31e346da63dc20573a26bb0777dd0190db5d4"` | Overrides the image tag |
| fsGroupFix.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| fsGroupFix.resources | object | `{}` | Specify resource needs as per https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9980` | override the host port used for health checking |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-agent"` | The repository within the registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| initContainers | list | `[]` |  |
| livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| readinessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `60` | Period seconds for readinessProbe |
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
| tolerations | list | `[]` |  |
| trustBundleFormat | string | `"pem"` | If using trustBundleURL, what format is the url. Choices are "pem" and "spiffe" |
| trustBundleURL | string | `""` | If set, obtain trust bundle from url instead of Kubernetes ConfigMap |
| trustDomain | string | `"example.org"` | The trust domain to be used for the SPIFFE identifiers |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| waitForIt.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` | The repository within the registry |
| waitForIt.image.tag | string | `"latest@sha256:deeaccb164a67a4d7f585c4d416641b1f422c029911a29d72beae28221f823df"` | Overrides the image tag |
| waitForIt.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| waitForIt.resources | object | `{}` |  |
| workloadAttestors.k8s.disableContainerSelectors | bool | `false` | Set to true if using holdApplicationUntilProxyStarts in Istio |
| workloadAttestors.k8s.skipKubeletVerification | bool | `true` | If true, kubelet certificate verification is skipped |
| workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |

----------------------------------------------
