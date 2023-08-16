# spire-server

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.1](https://img.shields.io/badge/AppVersion-1.7.1-informational?style=flat-square)

A Helm chart to install the SPIRE server.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.
>
> The recommended spire-controller-manager version is `0.2.2` to support arm64 nodes. If running with any
> prior version to `0.2.2` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |
| kfox1111 | <Kevin.Fox@pnnl.gov> |  |
| faisal-memon | <fymemon@yahoo.com> |  |
| edwbuck | <edwbuck@gmail.com> |  |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Tornjak

Tornjak is the UI and Control Plane for SPIRE [https://github.com/spiffe/tornjak](https://github.com/spiffe/tornjak) and it is composed of two components:

* Backend (this chart) - Tornjak APIs that extend SPIRE APIs with Control Plane functionality
* [Frontend](../tornjak-frontend/README.md) - Tornjak UI

When Tornjak is enabled, it is exposed on both http and https (if TLS server certs are configured). Tornjak handles a permanent redirect from `http` to `https` to ensure users always use the https endpoint.

In addition, you can configure a `client certificate authority`, this will make Tornjak backend verify Client certificates signed by this authority to enable mTLS authentication.

**Warning**: For production, we recommend configuring TLS certificates and client CA to protect Tornjak from unauthorized access.

### Tornjak with TLS Connection Type

TLS connection requires Tornjak to have access to TLS key and certificate.
Complete instruction on creating your own TLS certificate can be found [here](https://github.com/spiffe/tornjak/blob/main/examples/tls_mtls/README.md).
TLS Certificate and the private key must be provided to Tornjak via *TLS Secret*. Prior to deploying this Helm chart, create TLS Secret in the deployment namespace (e.g. `spire-server`)

```console
kubectl -n spire-server create secret tls tornjak-tls-secret --cert=client.crt --key=client.key
```

Once the charts are deployed, you can test the TLS connection with the following command (assuming localhost):

```console
curl --cacert CA/rootCA.crt https://localhost:10443
```

### Tornjak with mTLS Connection Type

mTLS connection allows Tornjak server validation by client and Tornjak client validation by Tornjak server. The server validation is identical to above TLS. Follow the steps to create
TLS secret with key and the certificate.

Additionally, you must provide the user CA to Tornjak server via `Secret` or `ConfigMap`.
Follow the steps to [create user CA for mTLS](https://github.com/spiffe/tornjak/blob/main/examples/tls_mtls/README.md), then create a *Secret* (or *ConfigMap*) prior to deploying this Helm chart.

Here is an example using a *Secret* in `spire-server` namespace:

```console
kubectl -n spire-server create secret generic tornjak-client-ca --from-file=ca.crt="CA/rootCA.crt"
```

Once the charts are deployed, you can test the mTLS connection with the following command (assuming localhost):

```console
curl  --cacert CA/rootCA.crt --key client.key --cert client.crt https://localhost:10443
```

### Tornjak with HTTP Connection Type

In order to run Tornjak with simple HTTP Connection only, make sure you don't create any `Secrets` or `ConfigMaps` listed above.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| bundleConfigMap | string | `"spire-bundle"` |  |
| caKeyType | string | `"rsa-2048"` | The CA key type to use, possible values are rsa-2048, rsa-4096, ec-p256, ec-p384 (AWS requires the use of RSA.  EC cryptography is not supported) |
| caTTL | string | `"24h"` |  |
| ca_subject.common_name | string | `"example.org"` |  |
| ca_subject.country | string | `"NL"` |  |
| ca_subject.organization | string | `"Example"` |  |
| clusterDomain | string | `"cluster.local"` |  |
| clusterName | string | `"example-cluster"` |  |
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Server ConfigMap |
| controllerManager.configMap.annotations | object | `{}` | Annotations to add to the Controller Manager ConfigMap |
| controllerManager.enabled | bool | `false` |  |
| controllerManager.identities.dnsNameTemplates | list | `[]` |  |
| controllerManager.identities.enabled | bool | `true` |  |
| controllerManager.identities.federatesWith | list | `[]` |  |
| controllerManager.identities.namespaceSelector | object | `{}` |  |
| controllerManager.identities.podSelector | object | `{}` |  |
| controllerManager.identities.spiffeIDTemplate | string | `"spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"` |  |
| controllerManager.ignoreNamespaces[0] | string | `"kube-system"` |  |
| controllerManager.ignoreNamespaces[1] | string | `"kube-public"` |  |
| controllerManager.ignoreNamespaces[2] | string | `"local-path-storage"` |  |
| controllerManager.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| controllerManager.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| controllerManager.image.repository | string | `"spiffe/spire-controller-manager"` | The repository within the registry |
| controllerManager.image.tag | string | `"0.2.3"` | Overrides the image tag |
| controllerManager.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| controllerManager.resources | object | `{}` |  |
| controllerManager.securityContext | object | `{}` |  |
| controllerManager.service.annotations | object | `{}` |  |
| controllerManager.service.port | int | `443` |  |
| controllerManager.service.type | string | `"ClusterIP"` |  |
| controllerManager.validatingWebhookConfiguration.failurePolicy | string | `"Fail"` |  |
| dataStore.sql.databaseName | string | `"spire"` | Only used by "postgres" or "mysql" |
| dataStore.sql.databaseType | string | `"sqlite3"` | Other supported databases are "postgres" and "mysql" |
| dataStore.sql.host | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.options | list | `[]` | Only used by "postgres" or "mysql" |
| dataStore.sql.password | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.plugin_data | object | `{}` | Settings from https://github.com/spiffe/spire/blob/main/doc/plugin_server_datastore_sql.md go in this section |
| dataStore.sql.port | int | `0` | If 0 (default), it will auto set to 5432 for postgres and 3306 for mysql. Only used by those databases. |
| dataStore.sql.username | string | `"spire"` | Only used by "postgres" or "mysql" |
| defaultJwtSvidTTL | string | `"1h"` |  |
| defaultX509SvidTTL | string | `"4h"` |  |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| federation.bundleEndpoint.address | string | `"0.0.0.0"` |  |
| federation.bundleEndpoint.port | int | `8443` |  |
| federation.enabled | bool | `false` |  |
| federation.ingress.annotations | object | `{}` |  |
| federation.ingress.className | string | `""` |  |
| federation.ingress.enabled | bool | `false` |  |
| federation.ingress.hosts[0].host | string | `"spire-server-federation.example.org"` |  |
| federation.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| federation.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| federation.ingress.tls | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-server"` | The repository within the registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"spire-server.example.org"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| jwtIssuer | string | `"https://oidc-discovery.example.org"` | The JWT issuer domain |
| keyManager.awsKMS.accessKeyID | Optional | `""` | Access key ID for the AWS account. It's recommended to use an IAM role instead. See [here](https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html) to learn how to annotate your SPIRE Server Service Account to assume an IAM role. |
| keyManager.awsKMS.enabled | bool | `false` |  |
| keyManager.awsKMS.keyPolicy | object | `{"existingConfigMap":"","policy":""}` | Policy to use when creating keys. If no policy is specified, a default policy will be used. |
| keyManager.awsKMS.keyPolicy.existingConfigMap | Optional | `""` | Name of a ConfigMap that has a `policy.json` file with the key policy in JSON format. |
| keyManager.awsKMS.keyPolicy.policy | Optional | `""` | Key policy in JSON format. |
| keyManager.awsKMS.region | string | `""` |  |
| keyManager.awsKMS.secretAccessKey | Optional | `""` | Secret access key for the AWS account. |
| keyManager.disk.enabled | bool | `true` |  |
| keyManager.memory.enabled | bool | `false` |  |
| livenessProbe.failureThreshold | int | `2` | Failure threshold count for livenessProbe |
| livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| livenessProbe.timeoutSeconds | int | `3` | Timeout in seconds for livenessProbe |
| logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeAttestor.k8sPsat.enabled | bool | `true` |  |
| nodeAttestor.k8sPsat.serviceAccountAllowList | list | `[]` |  |
| nodeSelector | object | `{}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| notifier.k8sbundle.namespace | string | `""` | Namespace to push the bundle into, if blank will default to SPIRE Server namespace |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.hostPath | string | `""` | Which path to use on the host when type = hostPath |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClass | string | `nil` |  |
| persistence.type | string | `"pvc"` | What type of volume to use for persistence. Valid options pvc (recommended), hostPath, emptyDir (testing only) |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| replicaCount | int | `1` | SPIRE server currently runs with a sqlite database. Scaling to multiple instances will not work until we use an external database. |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8081` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-server |
| tolerations | list | `[]` |  |
| tools.kubectl.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| tools.kubectl.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| tools.kubectl.image.repository | string | `"rancher/kubectl"` | The repository within the registry |
| tools.kubectl.image.tag | string | `""` | Overrides the image tag |
| tools.kubectl.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| topologySpreadConstraints | list | `[]` |  |
| tornjak.config.clientCA.name | string | `"tornjak-client-ca"` |  |
| tornjak.config.clientCA.type | string | `"Secret"` | Type of delivery for the user CA for mTLS client verification options are `Secret` or `ConfigMap` (required for `mtls` connectionType) |
| tornjak.config.dataStore | object | `{"driver":"sqlite3","file":"/run/spire/data/tornjak.sqlite3"}` | Persistent DB for storing Tornjak specific information |
| tornjak.config.tlsSecret | string | `"tornjak-tls-secret"` | Name of the secret containing server side key and certificate for TLS verification (required for `tls` or `mtls` connectionType) |
| tornjak.enabled | bool | `false` | Deploys Tornjak API (backend) (Not for production) |
| tornjak.image.pullPolicy | string | `"IfNotPresent"` | The Tornjak image pull policy |
| tornjak.image.registry | string | `"ghcr.io"` | The OCI registry to pull the Tornjak image from |
| tornjak.image.repository | string | `"spiffe/tornjak-backend"` | The repository within the registry |
| tornjak.image.tag | string | `"v1.2.2"` | Overrides the image tag |
| tornjak.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tornjak.resources | object | `{}` |  |
| tornjak.service.annotations | object | `{}` |  |
| tornjak.service.ports | object | `{"http":10000,"https":10443}` | Ports for tornjak |
| tornjak.service.type | string | `"ClusterIP"` |  |
| tornjak.startupProbe.failureThreshold | int | `3` |  |
| tornjak.startupProbe.initialDelaySeconds | int | `5` | Initial delay seconds for |
| tornjak.startupProbe.periodSeconds | int | `10` |  |
| tornjak.startupProbe.successThreshold | int | `1` |  |
| tornjak.startupProbe.timeoutSeconds | int | `5` |  |
| trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| upstreamAuthority.awsPCA.assumeRoleARN | Optional | `""` | ARN of an IAM role to assume |
| upstreamAuthority.awsPCA.caSigningTemplateARN | string | `""` | See Using Templates (https://docs.aws.amazon.com/acm-pca/latest/userguide/UsingTemplates.html) for possible values. |
| upstreamAuthority.awsPCA.certificateAuthorityARN | string | `""` | ARN of the "upstream" CA certificate |
| upstreamAuthority.awsPCA.enabled | bool | `false` |  |
| upstreamAuthority.awsPCA.endpoint | string | `""` | See AWS SDK Config docs (https://docs.aws.amazon.com/sdk-for-go/api/aws/#Config) for more information. |
| upstreamAuthority.awsPCA.region | string | `""` | AWS Region to use |
| upstreamAuthority.awsPCA.signingAlgorithm | string | `""` | See Issue Certificate (https://docs.aws.amazon.com/cli/latest/reference/acm-pca/issue-certificate.html) for possible values. |
| upstreamAuthority.awsPCA.supplementalBundlePath | Optional | `""` | Path to a file containing PEM-encoded CA certificates that should be additionally included in the bundle. |
| upstreamAuthority.certManager.ca.create | bool | `false` | Creates a Cert-Manager CA |
| upstreamAuthority.certManager.ca.duration | string | `"87600h"` | Duration of the CA. Defaults to 10 years. |
| upstreamAuthority.certManager.ca.privateKey.algorithm | string | `"ECDSA"` |  |
| upstreamAuthority.certManager.ca.privateKey.rotationPolicy | string | `""` |  |
| upstreamAuthority.certManager.ca.privateKey.size | int | `256` |  |
| upstreamAuthority.certManager.ca.renewBefore | string | `""` | How long to wait before renewing the CA |
| upstreamAuthority.certManager.enabled | bool | `false` |  |
| upstreamAuthority.certManager.issuer_group | string | `"cert-manager.io"` |  |
| upstreamAuthority.certManager.issuer_kind | string | `"Issuer"` |  |
| upstreamAuthority.certManager.issuer_name | string | `""` | Defaults to the release name, override if CA is provided outside of the chart |
| upstreamAuthority.certManager.kube_config_file | string | `""` |  |
| upstreamAuthority.certManager.namespace | string | `""` | Specify to use a namespace other then the one the chart is installed into |
| upstreamAuthority.certManager.rbac.create | bool | `true` |  |
| upstreamAuthority.disk.enabled | bool | `false` |  |
| upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |
| upstreamAuthority.spire.enabled | bool | `false` |  |
| upstreamAuthority.spire.server.address | string | `""` |  |
| upstreamAuthority.spire.server.port | int | `8081` |  |
| upstreamAuthority.spire.upstreamDriver | string | `""` |  |

----------------------------------------------
