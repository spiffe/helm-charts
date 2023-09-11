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

## Parameters

### SPIFFE CSI Driver Chart parameters

| Name                                     | Description                                                                                 | Value                                       |
| ---------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------- |
| `pluginName`                             | Set the csi driver name deployed to Kubernetes.                                             | `csi.spiffe.io`                             |
| `image.registry`                         | The OCI registry to pull the image from                                                     | `ghcr.io`                                   |
| `image.repository`                       | The repository within the registry                                                          | `spiffe/spiffe-csi-driver`                  |
| `image.pullPolicy`                       | The image pull policy                                                                       | `IfNotPresent`                              |
| `image.version`                          | This value is deprecated in favor of tag. (Will be removed in a future release)             | `""`                                        |
| `image.tag`                              | Overrides the image tag whose default is the chart appVersion                               | `""`                                        |
| `resources`                              | Resource requests and limits for spiffe-csi-driver                                          | `{}`                                        |
| `healthChecks.port`                      | The healthcheck port for spiffe-csi-driver                                                  | `9809`                                      |
| `livenessProbe.initialDelaySeconds`      | Initial delay seconds for livenessProbe                                                     | `5`                                         |
| `livenessProbe.timeoutSeconds`           | Timeout value in seconds for livenessProbe                                                  | `5`                                         |
| `imagePullSecrets`                       | Image pull secret details for spiffe-csi-driver                                             | `[]`                                        |
| `nameOverride`                           | Name override for spiffe-csi-driver                                                         | `""`                                        |
| `namespaceOverride`                      | Namespace to install spiffe-csi-driver                                                      | `""`                                        |
| `fullnameOverride`                       | Full name override for spiffe-csi-driver                                                    | `""`                                        |
| `serviceAccount.create`                  | Specifies whether a service account should be created                                       | `true`                                      |
| `serviceAccount.annotations`             | Annotations to add to the service account                                                   | `{}`                                        |
| `serviceAccount.name`                    | The name of the service account to use. If not set and create is true, a name is generated. | `""`                                        |
| `podAnnotations`                         | Pod annotations for spiffe-csi-driver                                                       | `{}`                                        |
| `podSecurityContext`                     | Security context for CSI driver pods                                                        | `{}`                                        |
| `securityContext.readOnlyRootFilesystem` | Flag for read only root filesystem                                                          | `true`                                      |
| `securityContext.privileged`             | Flag for specifying privileged mode                                                         | `true`                                      |
| `nodeSelector`                           | Node selector for CSI driver pods                                                           | `{}`                                        |
| `tolerations`                            | Tolerations for CSI driver pods                                                             | `[]`                                        |
| `nodeDriverRegistrar.image.registry`     | The OCI registry to pull the image from                                                     | `registry.k8s.io`                           |
| `nodeDriverRegistrar.image.repository`   | The repository within the registry                                                          | `sig-storage/csi-node-driver-registrar`     |
| `nodeDriverRegistrar.image.pullPolicy`   | The image pull policy                                                                       | `IfNotPresent`                              |
| `nodeDriverRegistrar.image.version`      | This value is deprecated in favor of tag. (Will be removed in a future release)             | `""`                                        |
| `nodeDriverRegistrar.image.tag`          | Overrides the image tag                                                                     | `v2.8.0`                                    |
| `nodeDriverRegistrar.resources`          | Resource requests and limits for CSI driver pods                                            | `{}`                                        |
| `agentSocketPath`                        | The unix socket path to the spire-agent                                                     | `/run/spire/agent-sockets/spire-agent.sock` |
| `kubeletPath`                            | Path to kubelet file                                                                        | `/var/lib/kubelet`                          |
| `priorityClassName`                      | Priority class assigned to daemonset pods                                                   | `""`                                        |
