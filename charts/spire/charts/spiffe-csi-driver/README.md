# spiffe-csi-driver

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.3](https://img.shields.io/badge/AppVersion-0.2.3-informational?style=flat-square)

A Helm chart to install the SPIFFE CSI driver.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: The recommended version is `0.2.3` to support arm64 nodes. If running with any
> prior version to `0.2.3` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

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
| agentSocketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | The unix socket path to the spire-agent |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9809` |  |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spiffe-csi-driver"` | The repository within the registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| kubeletPath | string | `"/var/lib/kubelet"` |  |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| livenessProbe.timeoutSeconds | int | `5` | Timeout value in seconds for livenessProbe |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| nodeDriverRegistrar.image.registry | string | `"registry.k8s.io"` | The OCI registry to pull the image from |
| nodeDriverRegistrar.image.repository | string | `"sig-storage/csi-node-driver-registrar"` | The repository within the registry |
| nodeDriverRegistrar.image.tag | string | `"v2.8.0"` | Overrides the image tag |
| nodeDriverRegistrar.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| nodeDriverRegistrar.resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| pluginName | string | `"csi.spiffe.io"` | Set the csi driver name deployed to Kubernetes. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| resources | object | `{}` |  |
| securityContext.privileged | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |

----------------------------------------------
