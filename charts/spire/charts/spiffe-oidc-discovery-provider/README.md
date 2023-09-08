# spiffe-oidc-discovery-provider

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.2](https://img.shields.io/badge/AppVersion-1.7.2-informational?style=flat-square)

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

## Parameters

### Chart parameters

| Name                                                  | Description                                                                                          | Value                                                                            |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `agentSocketName`                                     | The name of the spire-agent unix socket                                                              | `spire-agent.sock`                                                               |
| `replicaCount`                                        | Replica count                                                                                        | `1`                                                                              |
| `namespaceOverride`                                   | Namespace override                                                                                   | `""`                                                                             |
| `annotations`                                         | Annotations for the deployment                                                                       | `{}`                                                                             |
| `image.registry`                                      | The OCI registry to pull the image from                                                              | `ghcr.io`                                                                        |
| `image.repository`                                    | The repository within the registry                                                                   | `spiffe/oidc-discovery-provider`                                                 |
| `image.pullPolicy`                                    | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `image.version`                                       | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `image.tag`                                           | Overrides the image tag whose default is the chart appVersion                                        | `""`                                                                             |
| `resources`                                           | Resource requests and limits                                                                         | `{}`                                                                             |
| `service.type`                                        | Service type                                                                                         | `ClusterIP`                                                                      |
| `service.port`                                        | Service port                                                                                         | `80`                                                                             |
| `service.annotations`                                 | Annotations for service resource                                                                     | `{}`                                                                             |
| `configMap.annotations`                               | Annotations to add to the SPIFFE OIDC Discovery Provider ConfigMap                                   | `{}`                                                                             |
| `podSecurityContext`                                  | Pod security context for OIDC discovery provider pods                                                | `{}`                                                                             |
| `securityContext`                                     | Security context for OIDC discovery provider deployment                                              | `{}`                                                                             |
| `readinessProbe.initialDelaySeconds`                  | Initial delay seconds for readinessProbe                                                             | `5`                                                                              |
| `readinessProbe.periodSeconds`                        | Period seconds for readinessProbe                                                                    | `5`                                                                              |
| `livenessProbe.initialDelaySeconds`                   | Initial delay seconds for livenessProbe                                                              | `5`                                                                              |
| `livenessProbe.periodSeconds`                         | Period seconds for livenessProbe                                                                     | `5`                                                                              |
| `podAnnotations`                                      | Pod annotations for Spire OIDC discovery provider                                                    | `{}`                                                                             |
| `insecureScheme.enabled`                              | Flag to enable insecure schema                                                                       | `false`                                                                          |
| `insecureScheme.nginx.image.registry`                 | The OCI registry to pull the image from                                                              | `docker.io`                                                                      |
| `insecureScheme.nginx.image.repository`               | The repository within the registry                                                                   | `nginxinc/nginx-unprivileged`                                                    |
| `insecureScheme.nginx.image.pullPolicy`               | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `insecureScheme.nginx.image.version`                  | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `insecureScheme.nginx.image.tag`                      | Overrides the image tag whose default is the chart appVersion                                        | `1.24.0-alpine`                                                                  |
| `insecureScheme.nginx.resources`                      | Resource requests and limits                                                                         | `{}`                                                                             |
| `jwtIssuer`                                           | Path to JWT issuer                                                                                   | `https://oidc-discovery.example.org`                                             |
| `config.logLevel`                                     | The log level, valid values are "debug", "info", "warn", and "error"                                 | `info`                                                                           |
| `config.additionalDomains`                            | Add additional domains that can be used for oidc discovery                                           | `[]`                                                                             |
| `config.acme.tosAccepted`                             | Flag for Terms of Service acceptance                                                                 | `false`                                                                          |
| `config.acme.cacheDir`                                | Path for cache directory                                                                             | `/run/spire`                                                                     |
| `config.acme.directoryUrl`                            | URL for acme directory                                                                               | `https://acme-v02.api.letsencrypt.org/directory`                                 |
| `config.acme.emailAddress`                            | Email address for registration                                                                       | `letsencrypt@example.org`                                                        |
| `imagePullSecrets`                                    | Image pull secret names                                                                              | `[]`                                                                             |
| `nameOverride`                                        | Name override                                                                                        | `""`                                                                             |
| `fullnameOverride`                                    | Full name override                                                                                   | `""`                                                                             |
| `serviceAccount.create`                               | Specifies whether a service account should be created                                                | `true`                                                                           |
| `serviceAccount.annotations`                          | Annotations to add to the service account                                                            | `{}`                                                                             |
| `serviceAccount.name`                                 | The name of the service account to use. If not set and create is true, a name is generated.          | `""`                                                                             |
| `deleteHook.enabled`                                  | Enable Helm hooks to autofix common delete issues (should be disabled when using `helm template`)    | `true`                                                                           |
| `autoscaling.enabled`                                 | Flag to enable autoscaling                                                                           | `false`                                                                          |
| `autoscaling.minReplicas`                             | Minimum replicas for autoscaling                                                                     | `1`                                                                              |
| `autoscaling.maxReplicas`                             | Maximum replicas for autoscaling                                                                     | `5`                                                                              |
| `autoscaling.targetCPUUtilizationPercentage`          | Target CPU utlization that triggers autoscaling                                                      | `80`                                                                             |
| `autoscaling.targetMemoryUtilizationPercentage`       | Target Memory utlization that triggers autoscaling                                                   | `80`                                                                             |
| `nodeSelector`                                        | Node selector                                                                                        | `{}`                                                                             |
| `tolerations`                                         | iist of tolerations                                                                                  | `[]`                                                                             |
| `affinity`                                            | Node affinity                                                                                        | `{}`                                                                             |
| `trustDomain`                                         | Set the trust domain to be used for the SPIFFE identifiers                                           | `example.org`                                                                    |
| `clusterDomain`                                       | The name of the Kubernetes cluster (`kubeadm init --service-dns-domain`)                             | `cluster.local`                                                                  |
| `telemetry.prometheus.enabled`                        | Flag to enable prometheus monitoring                                                                 | `false`                                                                          |
| `telemetry.prometheus.port`                           | Port for prometheus metrics                                                                          | `9988`                                                                           |
| `telemetry.prometheus.podMonitor.enabled`             | Enable podMonitor for prometheus                                                                     | `false`                                                                          |
| `telemetry.prometheus.podMonitor.namespace`           | Override where to install the podMonitor, if not set will use the same namespace as the helm release | `""`                                                                             |
| `telemetry.prometheus.podMonitor.labels`              | Pod labels to filter for prometheus monitoring                                                       | `{}`                                                                             |
| `telemetry.prometheus.nginxExporter.image.registry`   | The OCI registry to pull the image from                                                              | `docker.io`                                                                      |
| `telemetry.prometheus.nginxExporter.image.repository` | The repository within the registry                                                                   | `nginx/nginx-prometheus-exporter`                                                |
| `telemetry.prometheus.nginxExporter.image.pullPolicy` | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `telemetry.prometheus.nginxExporter.image.version`    | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `telemetry.prometheus.nginxExporter.image.tag`        | Overrides the image tag whose default is the chart appVersion                                        | `0.11.0`                                                                         |
| `telemetry.prometheus.nginxExporter.resources`        | Resource requests and limits                                                                         | `{}`                                                                             |
| `ingress.enabled`                                     | Flag to enable ingress                                                                               | `false`                                                                          |
| `ingress.className`                                   | Ingress class name                                                                                   | `""`                                                                             |
| `ingress.annotations`                                 | Annotations for ingress object                                                                       | `{}`                                                                             |
| `ingress.hosts`                                       | Host paths for ingress object                                                                        | `[]`                                                                             |
| `ingress.tls`                                         | Secrets containining TLS certs to enable https on ingress                                            | `[]`                                                                             |
| `tests.hostAliases`                                   | List of host aliases for testing                                                                     | `[]`                                                                             |
| `tests.tls.enabled`                                   | Flag for enabling tls for tests                                                                      | `false`                                                                          |
| `tests.tls.customCA`                                  | Custom CA value for tests                                                                            | `""`                                                                             |
| `tests.bash.image.registry`                           | The OCI registry to pull the image from                                                              | `cgr.dev`                                                                        |
| `tests.bash.image.repository`                         | The repository within the registry                                                                   | `chainguard/bash`                                                                |
| `tests.bash.image.pullPolicy`                         | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `tests.bash.image.version`                            | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `tests.bash.image.tag`                                | Overrides the image tag whose default is the chart appVersion                                        | `latest@sha256:96ab1600d945b4a99c8610b5c8b31e346da63dc20573a26bb0777dd0190db5d4` |
| `tests.toolkit.image.registry`                        | The OCI registry to pull the image from                                                              | `cgr.dev`                                                                        |
| `tests.toolkit.image.repository`                      | The repository within the registry                                                                   | `chainguard/slim-toolkit-debug`                                                  |
| `tests.toolkit.image.pullPolicy`                      | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `tests.toolkit.image.version`                         | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `tests.toolkit.image.tag`                             | Overrides the image tag whose default is the chart appVersion                                        | `latest@sha256:d717d0a2c88518f8e36d9cfe1571639a40617e8c4291e34876d46bdeefb1ab5a` |
| `tests.busybox.image.registry`                        | The OCI registry to pull the image from                                                              | `""`                                                                             |
| `tests.busybox.image.repository`                      | The repository within the registry                                                                   | `busybox`                                                                        |
| `tests.busybox.image.pullPolicy`                      | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `tests.busybox.image.version`                         | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `tests.busybox.image.tag`                             | Overrides the image tag whose default is the chart appVersion                                        | `uclibc@sha256:3e516f71d8801b0ce6c3f8f8e4f11093ec04e168177a90f1da4498014ee06b6b` |
| `tests.agent.image.registry`                          | The OCI registry to pull the image from                                                              | `ghcr.io`                                                                        |
| `tests.agent.image.repository`                        | The repository within the registry                                                                   | `spiffe/spire-agent`                                                             |
| `tests.agent.image.pullPolicy`                        | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `tests.agent.image.version`                           | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `tests.agent.image.tag`                               | Overrides the image tag whose default is the chart appVersion                                        | `""`                                                                             |
| `tools.kubectl.image.registry`                        | The OCI registry to pull the image from                                                              | `docker.io`                                                                      |
| `tools.kubectl.image.repository`                      | The repository within the registry                                                                   | `rancher/kubectl`                                                                |
| `tools.kubectl.image.pullPolicy`                      | The image pull policy                                                                                | `IfNotPresent`                                                                   |
| `tools.kubectl.image.version`                         | This value is deprecated in favor of tag. (Will be removed in a future release)                      | `""`                                                                             |
| `tools.kubectl.image.tag`                             | Overrides the image tag whose default is the chart appVersion                                        | `""`                                                                             |
