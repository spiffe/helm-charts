# spiffe-csi-driver

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.3](https://img.shields.io/badge/AppVersion-0.2.3-informational?style=flat-square)

A Helm chart to install the SPIFFE CSI driver.

> **Note**: The recommended version is `0.2.3` to support arm64 nodes. If running with any
> prior version to `0.2.3` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agentSocketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | Override where the driver looks for the socket. Only used if socketMacroName is unchanged. |
| fullnameOverride | string | `""` |  |
| healthChecks.port | int | `9809` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spiffe-csi-driver"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| nodeDriverRegistrar.image.registry | string | `"registry.k8s.io"` |  |
| nodeDriverRegistrar.image.repository | string | `"sig-storage/csi-node-driver-registrar"` |  |
| nodeDriverRegistrar.image.version | string | `"v2.6.2"` |  |
| nodeDriverRegistrar.resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| pluginName | string | `"csi.spiffe.io"` | Set the csi driver name deployed to Kubernetes. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| resources | object | `{}` |  |
| securityContext.privileged | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |

----------------------------------------------
