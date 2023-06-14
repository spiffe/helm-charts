# spire

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.8.1](https://img.shields.io/badge/Version-0.8.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.4](https://img.shields.io/badge/AppVersion-1.6.4-informational?style=flat-square)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)

A Helm chart for deploying the complete Spire stack including: spire-server, spire-agent, spiffe-csi-driver, spiffe-oidc-discovery-provider and spire-controller-manager.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Version support

> **Note**: This Chart is still in development and still subject to change the API (`values.yaml`).
> Until we reach a `1.0.0` version of the chart we can't guarantee backwards compatibility although
> we do aim for as much stability as possible.

| Dependency | Supported Versions |
|:-----------|:-------------------|
| SPIRE      | `1.5.3+`, `1.6.3+` |
| Helm       | `3.x`              |
| Kubernetes | `1.22+`            |

> **Note**: For Kubernetes, we will officially support the last 3 versions as described in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions). Any version before the last 3 we will try to support as long it doesn't bring security issues or any big maintenance burden.

## Prerequisites

Please note this chart requires `Projected Service Account Tokens` which has to be enabled on your k8s api server.

To enable Projected Service Account Tokens on Docker for Mac/Windows run the following
command to SSH into the Docker Desktop K8s VM.

```bash
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

Then add the following to `/etc/kubernetes/manifests/kube-apiserver.yaml`

```yaml
spec:
  containers:
    - command:
        - kube-apiserver
        - --api-audiences=api,spire-server
        - --service-account-issuer=api,spire-agent
        - --service-account-key-file=/run/config/pki/sa.pub
        - --service-account-signing-key-file=/run/config/pki/sa.key
```

## Usage

To utilize Spire in your own workloads you should add the following to your workload:

```diff
 apiVersion: v1
 kind: Pod
 metadata:
   name: my-app
 spec:
   containers:
     - name: my-app
       image: "my-app:latest"
       imagePullPolicy: Always
+      volumeMounts:
+        - name: spiffe-workload-api
+          mountPath: /spiffe-workload-api
+          readOnly: true
       resources:
         requests:
           cpu: 200m
           memory: 32Mi
         limits:
           cpu: 500m
           memory: 64Mi
+  volumes:
+    - name: spiffe-workload-api
+      csi:
+        driver: "csi.spiffe.io"
+        readOnly: true
```

Now you can interact with the Spire agent socket from your own application. The socket is mounted on `/spiffe-workload-api/spire-agent.sock`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |
| kfox1111 | <Kevin.Fox@pnnl.gov> |  |
| faisal-memon | <fymemon@yahoo.com> |  |
| edwbuck | <edwbuck@gmail.com> |  |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://./charts/spiffe-csi-driver | spiffe-csi-driver | 0.1.0 |
| file://./charts/spiffe-oidc-discovery-provider | spiffe-oidc-discovery-provider | 0.1.0 |
| file://./charts/spire-agent | spire-agent | 0.1.0 |
| file://./charts/spire-server | spire-server | 0.1.0 |
| file://./charts/tornjak-frontend | tornjak-frontend | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.k8s.clusterDomain | string | `"cluster.local"` |  |
| global.spire.bundleConfigMap | string | `""` | Override all instances of bundleConfigMap |
| global.spire.clusterName | string | `"example-cluster"` |  |
| global.spire.image.registry | string | `""` | Override all Spire image registries at once |
| global.spire.trustDomain | string | `"example.org"` | The trust domain to be used for the SPIFFE identifiers |
| spiffe-csi-driver.enabled | bool | `true` | Enables deployment of CSI driver |
| spiffe-oidc-discovery-provider.enabled | bool | `false` | Enables deployment of OIDC discovery provider |
| spire-agent.enabled | bool | `true` | Enables deployment of SPIRE Agent(s) |
| spire-agent.nameOverride | string | `"agent"` |  |
| spire-server.controllerManager.enabled | bool | `true` | Enables deployment of Controller Manager |
| spire-server.enabled | bool | `true` | Enables deployment of SPIRE Server |
| spire-server.nameOverride | string | `"server"` |  |
| tornjak-frontend.enabled | bool | `false` | Enables deployment of Tornjak frontend/UI (Not for production) |
| spiffe-csi-driver.agentSocketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | The unix socket path to the spire-agent |
| spiffe-csi-driver.fullnameOverride | string | `""` |  |
| spiffe-csi-driver.healthChecks.port | int | `9809` |  |
| spiffe-csi-driver.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spiffe-csi-driver.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| spiffe-csi-driver.image.repository | string | `"spiffe/spiffe-csi-driver"` | The repository within the registry |
| spiffe-csi-driver.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| spiffe-csi-driver.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spiffe-csi-driver.imagePullSecrets | list | `[]` |  |
| spiffe-csi-driver.kubeletPath | string | `"/var/lib/kubelet"` |  |
| spiffe-csi-driver.livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| spiffe-csi-driver.livenessProbe.timeoutSeconds | int | `5` | Timeout value in seconds for livenessProbe |
| spiffe-csi-driver.nameOverride | string | `""` |  |
| spiffe-csi-driver.namespaceOverride | string | `""` |  |
| spiffe-csi-driver.nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spiffe-csi-driver.nodeDriverRegistrar.image.registry | string | `"registry.k8s.io"` | The OCI registry to pull the image from |
| spiffe-csi-driver.nodeDriverRegistrar.image.repository | string | `"sig-storage/csi-node-driver-registrar"` | The repository within the registry |
| spiffe-csi-driver.nodeDriverRegistrar.image.tag | string | `"v2.8.0"` | Overrides the image tag |
| spiffe-csi-driver.nodeDriverRegistrar.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spiffe-csi-driver.nodeDriverRegistrar.resources | object | `{}` |  |
| spiffe-csi-driver.nodeSelector | object | `{}` |  |
| spiffe-csi-driver.pluginName | string | `"csi.spiffe.io"` | Set the csi driver name deployed to Kubernetes. |
| spiffe-csi-driver.podAnnotations | object | `{}` |  |
| spiffe-csi-driver.podSecurityContext | object | `{}` |  |
| spiffe-csi-driver.priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| spiffe-csi-driver.resources | object | `{}` |  |
| spiffe-csi-driver.securityContext.privileged | bool | `true` |  |
| spiffe-csi-driver.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| spiffe-csi-driver.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| spiffe-csi-driver.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| spiffe-csi-driver.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| spiffe-oidc-discovery-provider.affinity | object | `{}` |  |
| spiffe-oidc-discovery-provider.agentSocketName | string | `"spire-agent.sock"` | The name of the spire-agent unix socket |
| spiffe-oidc-discovery-provider.autoscaling.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.autoscaling.maxReplicas | int | `5` |  |
| spiffe-oidc-discovery-provider.autoscaling.minReplicas | int | `1` |  |
| spiffe-oidc-discovery-provider.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| spiffe-oidc-discovery-provider.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| spiffe-oidc-discovery-provider.clusterDomain | string | `"cluster.local"` |  |
| spiffe-oidc-discovery-provider.config.acme.cacheDir | string | `"/run/spire"` |  |
| spiffe-oidc-discovery-provider.config.acme.directoryUrl | string | `"https://acme-v02.api.letsencrypt.org/directory"` |  |
| spiffe-oidc-discovery-provider.config.acme.emailAddress | string | `"letsencrypt@example.org"` |  |
| spiffe-oidc-discovery-provider.config.acme.tosAccepted | bool | `false` |  |
| spiffe-oidc-discovery-provider.config.domains[0] | string | `"localhost"` |  |
| spiffe-oidc-discovery-provider.config.domains[1] | string | `"oidc-discovery.example.org"` |  |
| spiffe-oidc-discovery-provider.config.logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| spiffe-oidc-discovery-provider.configMap.annotations | object | `{}` | Annotations to add to the SPIFFE OIDC Discovery Provider ConfigMap |
| spiffe-oidc-discovery-provider.fullnameOverride | string | `""` |  |
| spiffe-oidc-discovery-provider.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spiffe-oidc-discovery-provider.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| spiffe-oidc-discovery-provider.image.repository | string | `"spiffe/oidc-discovery-provider"` | The repository within the registry |
| spiffe-oidc-discovery-provider.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| spiffe-oidc-discovery-provider.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spiffe-oidc-discovery-provider.imagePullSecrets | list | `[]` |  |
| spiffe-oidc-discovery-provider.ingress.annotations | object | `{}` |  |
| spiffe-oidc-discovery-provider.ingress.className | string | `""` |  |
| spiffe-oidc-discovery-provider.ingress.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.ingress.hosts[0].host | string | `"oidc-discovery.example.org"` |  |
| spiffe-oidc-discovery-provider.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| spiffe-oidc-discovery-provider.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| spiffe-oidc-discovery-provider.ingress.tls | list | `[]` |  |
| spiffe-oidc-discovery-provider.insecureScheme.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.image.repository | string | `"nginxinc/nginx-unprivileged"` | The repository within the registry |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.image.tag | string | `"1.24.0-alpine"` | Overrides the image tag |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spiffe-oidc-discovery-provider.insecureScheme.nginx.resources | object | `{}` |  |
| spiffe-oidc-discovery-provider.livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| spiffe-oidc-discovery-provider.livenessProbe.periodSeconds | int | `5` | Period seconds for livenessProbe |
| spiffe-oidc-discovery-provider.nameOverride | string | `""` |  |
| spiffe-oidc-discovery-provider.namespaceOverride | string | `""` |  |
| spiffe-oidc-discovery-provider.nodeSelector | object | `{}` |  |
| spiffe-oidc-discovery-provider.podAnnotations | object | `{}` |  |
| spiffe-oidc-discovery-provider.podSecurityContext | object | `{}` |  |
| spiffe-oidc-discovery-provider.readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| spiffe-oidc-discovery-provider.readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| spiffe-oidc-discovery-provider.replicaCount | int | `1` |  |
| spiffe-oidc-discovery-provider.resources | object | `{}` |  |
| spiffe-oidc-discovery-provider.securityContext | object | `{}` |  |
| spiffe-oidc-discovery-provider.service.annotations | object | `{}` |  |
| spiffe-oidc-discovery-provider.service.port | int | `80` |  |
| spiffe-oidc-discovery-provider.service.type | string | `"ClusterIP"` |  |
| spiffe-oidc-discovery-provider.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| spiffe-oidc-discovery-provider.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| spiffe-oidc-discovery-provider.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| spiffe-oidc-discovery-provider.telemetry.prometheus.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.image.repository | string | `"nginx/nginx-prometheus-exporter"` | The repository within the registry |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.image.tag | string | `"0.11.0"` | Overrides the image tag |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spiffe-oidc-discovery-provider.telemetry.prometheus.nginxExporter.resources | object | `{}` |  |
| spiffe-oidc-discovery-provider.telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| spiffe-oidc-discovery-provider.telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spiffe-oidc-discovery-provider |
| spiffe-oidc-discovery-provider.telemetry.prometheus.port | int | `9988` |  |
| spiffe-oidc-discovery-provider.tolerations | list | `[]` |  |
| spiffe-oidc-discovery-provider.trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| spire-agent.bundleConfigMap | string | `"spire-bundle"` |  |
| spire-agent.clusterName | string | `"example-cluster"` |  |
| spire-agent.configMap.annotations | object | `{}` | Annotations to add to the SPIRE Agent ConfigMap |
| spire-agent.extraContainers | list | `[]` |  |
| spire-agent.extraVolumeMounts | list | `[]` |  |
| spire-agent.extraVolumes | list | `[]` |  |
| spire-agent.fullnameOverride | string | `""` |  |
| spire-agent.healthChecks.port | int | `9980` | override the host port used for health checking |
| spire-agent.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spire-agent.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| spire-agent.image.repository | string | `"spiffe/spire-agent"` | The repository within the registry |
| spire-agent.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| spire-agent.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-agent.imagePullSecrets | list | `[]` |  |
| spire-agent.initContainers | list | `[]` |  |
| spire-agent.livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| spire-agent.livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| spire-agent.logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| spire-agent.nameOverride | string | `""` |  |
| spire-agent.namespaceOverride | string | `""` |  |
| spire-agent.nodeSelector | object | `{}` |  |
| spire-agent.podAnnotations | object | `{}` |  |
| spire-agent.podSecurityContext | object | `{}` |  |
| spire-agent.priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| spire-agent.readinessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for readinessProbe |
| spire-agent.readinessProbe.periodSeconds | int | `60` | Period seconds for readinessProbe |
| spire-agent.resources | object | `{}` |  |
| spire-agent.securityContext | object | `{}` |  |
| spire-agent.server.address | string | `""` |  |
| spire-agent.server.namespaceOverride | string | `""` |  |
| spire-agent.server.port | int | `8081` |  |
| spire-agent.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| spire-agent.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| spire-agent.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| spire-agent.socketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | The unix socket path to the spire-agent |
| spire-agent.telemetry.prometheus.enabled | bool | `false` |  |
| spire-agent.telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| spire-agent.telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| spire-agent.telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-agent |
| spire-agent.telemetry.prometheus.port | int | `9988` |  |
| spire-agent.trustBundleFormat | string | `"pem"` | If using trustBundleURL, what format is the url. Choices are "pem" and "spiffe" |
| spire-agent.trustBundleURL | string | `""` | If set, obtain trust bundle from url instead of Kubernetes ConfigMap |
| spire-agent.trustDomain | string | `"example.org"` | The trust domain to be used for the SPIFFE identifiers |
| spire-agent.waitForIt.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spire-agent.waitForIt.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| spire-agent.waitForIt.image.repository | string | `"chainguard/wait-for-it"` | The repository within the registry |
| spire-agent.waitForIt.image.tag | string | `"latest-20230517"` | Overrides the image tag |
| spire-agent.waitForIt.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-agent.waitForIt.resources | object | `{}` |  |
| spire-agent.workloadAttestors.k8s.skipKubeletVerification | bool | `true` | If true, kubelet certificate verification is skipped |
| spire-agent.workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |
| spire-server.affinity | object | `{}` |  |
| spire-server.autoscaling.enabled | bool | `false` |  |
| spire-server.autoscaling.maxReplicas | int | `100` |  |
| spire-server.autoscaling.minReplicas | int | `1` |  |
| spire-server.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| spire-server.bundleConfigMap | string | `"spire-bundle"` |  |
| spire-server.caKeyType | string | `"rsa-2048"` | The CA key type to use, possible values are rsa-2048, rsa-4096, ec-p256, ec-p384 (AWS requires the use of RSA.  EC cryptography is not supported) |
| spire-server.caTTL | string | `"24h"` |  |
| spire-server.ca_subject.common_name | string | `"example.org"` |  |
| spire-server.ca_subject.country | string | `"NL"` |  |
| spire-server.ca_subject.organization | string | `"Example"` |  |
| spire-server.clusterDomain | string | `"cluster.local"` |  |
| spire-server.clusterName | string | `"example-cluster"` |  |
| spire-server.configMap.annotations | object | `{}` | Annotations to add to the SPIRE Server ConfigMap |
| spire-server.controllerManager.configMap.annotations | object | `{}` | Annotations to add to the Controller Manager ConfigMap |
| spire-server.controllerManager.enabled | bool | `false` |  |
| spire-server.controllerManager.identities.dnsNameTemplates | list | `[]` |  |
| spire-server.controllerManager.identities.enabled | bool | `true` |  |
| spire-server.controllerManager.identities.namespaceSelector | object | `{}` |  |
| spire-server.controllerManager.identities.podSelector | object | `{}` |  |
| spire-server.controllerManager.identities.spiffeIDTemplate | string | `"spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"` |  |
| spire-server.controllerManager.ignoreNamespaces[0] | string | `"kube-system"` |  |
| spire-server.controllerManager.ignoreNamespaces[1] | string | `"kube-public"` |  |
| spire-server.controllerManager.ignoreNamespaces[2] | string | `"local-path-storage"` |  |
| spire-server.controllerManager.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spire-server.controllerManager.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| spire-server.controllerManager.image.repository | string | `"spiffe/spire-controller-manager"` | The repository within the registry |
| spire-server.controllerManager.image.tag | string | `"0.2.2"` | Overrides the image tag |
| spire-server.controllerManager.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-server.controllerManager.resources | object | `{}` |  |
| spire-server.controllerManager.securityContext | object | `{}` |  |
| spire-server.controllerManager.service.annotations | object | `{}` |  |
| spire-server.controllerManager.service.port | int | `443` |  |
| spire-server.controllerManager.service.type | string | `"ClusterIP"` |  |
| spire-server.controllerManager.validatingWebhookConfiguration.failurePolicy | string | `"Fail"` |  |
| spire-server.controllerManager.validatingWebhookConfiguration.upgradeHook.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spire-server.controllerManager.validatingWebhookConfiguration.upgradeHook.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| spire-server.controllerManager.validatingWebhookConfiguration.upgradeHook.image.repository | string | `"rancher/kubectl"` | The repository within the registry |
| spire-server.controllerManager.validatingWebhookConfiguration.upgradeHook.image.tag | string | `""` | Overrides the image tag |
| spire-server.controllerManager.validatingWebhookConfiguration.upgradeHook.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-server.dataStore.sql.databaseName | string | `"spire"` | Only used by "postgres" or "mysql" |
| spire-server.dataStore.sql.databaseType | string | `"sqlite3"` | Other supported databases are "postgres" and "mysql" |
| spire-server.dataStore.sql.host | string | `""` | Only used by "postgres" or "mysql" |
| spire-server.dataStore.sql.options | list | `[]` | Only used by "postgres" or "mysql" |
| spire-server.dataStore.sql.password | string | `""` | Only used by "postgres" or "mysql" |
| spire-server.dataStore.sql.plugin_data | object | `{}` | Settings from https://github.com/spiffe/spire/blob/main/doc/plugin_server_datastore_sql.md go in this section |
| spire-server.dataStore.sql.port | int | `0` | If 0 (default), it will auto set to 5432 for postgres and 3306 for mysql. Only used by those databases. |
| spire-server.dataStore.sql.username | string | `"spire"` | Only used by "postgres" or "mysql" |
| spire-server.defaultJwtSvidTTL | string | `"1h"` |  |
| spire-server.defaultX509SvidTTL | string | `"4h"` |  |
| spire-server.extraContainers | list | `[]` |  |
| spire-server.extraVolumeMounts | list | `[]` |  |
| spire-server.extraVolumes | list | `[]` |  |
| spire-server.federation.bundleEndpoint.address | string | `"0.0.0.0"` |  |
| spire-server.federation.bundleEndpoint.port | int | `8443` |  |
| spire-server.federation.enabled | bool | `false` |  |
| spire-server.federation.ingress.annotations | object | `{}` |  |
| spire-server.federation.ingress.className | string | `""` |  |
| spire-server.federation.ingress.enabled | bool | `false` |  |
| spire-server.federation.ingress.hosts[0].host | string | `"spire-server-federation.example.org"` |  |
| spire-server.federation.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| spire-server.federation.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| spire-server.federation.ingress.tls | list | `[]` |  |
| spire-server.fullnameOverride | string | `""` |  |
| spire-server.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| spire-server.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| spire-server.image.repository | string | `"spiffe/spire-server"` | The repository within the registry |
| spire-server.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| spire-server.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-server.imagePullSecrets | list | `[]` |  |
| spire-server.ingress.annotations | object | `{}` |  |
| spire-server.ingress.className | string | `""` |  |
| spire-server.ingress.enabled | bool | `false` |  |
| spire-server.ingress.hosts[0].host | string | `"spire-server.example.org"` |  |
| spire-server.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| spire-server.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| spire-server.ingress.tls | list | `[]` |  |
| spire-server.initContainers | list | `[]` |  |
| spire-server.jwtIssuer | string | `"oidc-discovery.example.org"` | The JWT issuer domain |
| spire-server.livenessProbe.failureThreshold | int | `2` | Failure threshold count for livenessProbe |
| spire-server.livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| spire-server.livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| spire-server.livenessProbe.timeoutSeconds | int | `3` | Timeout in seconds for livenessProbe |
| spire-server.logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| spire-server.nameOverride | string | `""` |  |
| spire-server.namespaceOverride | string | `""` |  |
| spire-server.nodeAttestor.k8sPsat.enabled | bool | `true` |  |
| spire-server.nodeAttestor.k8sPsat.serviceAccountAllowList | list | `[]` |  |
| spire-server.nodeSelector | object | `{}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| spire-server.notifier.k8sbundle.namespace | string | `""` | Namespace to push the bundle into, if blank will default to SPIRE Server namespace |
| spire-server.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| spire-server.persistence.size | string | `"1Gi"` |  |
| spire-server.persistence.storageClass | string | `nil` |  |
| spire-server.podAnnotations | object | `{}` |  |
| spire-server.podSecurityContext | object | `{}` |  |
| spire-server.readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| spire-server.readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| spire-server.replicaCount | int | `1` | SPIRE server currently runs with a sqlite database. Scaling to multiple instances will not work until we use an external database. |
| spire-server.resources | object | `{}` |  |
| spire-server.securityContext | object | `{}` |  |
| spire-server.service.annotations | object | `{}` |  |
| spire-server.service.port | int | `8081` |  |
| spire-server.service.type | string | `"ClusterIP"` |  |
| spire-server.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| spire-server.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| spire-server.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| spire-server.telemetry.prometheus.enabled | bool | `false` |  |
| spire-server.telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| spire-server.telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| spire-server.telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-server |
| spire-server.tolerations | list | `[]` |  |
| spire-server.topologySpreadConstraints | list | `[]` |  |
| spire-server.tornjak.config.dataStore | object | `{"driver":"sqlite3","file":"/run/spire/data/tornjak.sqlite3"}` | persistent DB for storing Tornjak specific information |
| spire-server.tornjak.enabled | bool | `false` | Deploys Tornjak API (backend) (Not for production) |
| spire-server.tornjak.image.pullPolicy | string | `"IfNotPresent"` | The Tornjak image pull policy |
| spire-server.tornjak.image.registry | string | `"ghcr.io"` | The OCI registry to pull the Tornjak image from |
| spire-server.tornjak.image.repository | string | `"spiffe/tornjak-backend"` | The repository within the registry |
| spire-server.tornjak.image.tag | string | `"v1.2.2"` | Overrides the image tag |
| spire-server.tornjak.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| spire-server.tornjak.resources | object | `{}` |  |
| spire-server.tornjak.service.annotations | object | `{}` |  |
| spire-server.tornjak.service.port | int | `10000` |  |
| spire-server.tornjak.service.type | string | `"ClusterIP"` |  |
| spire-server.tornjak.startupProbe.failureThreshold | int | `3` |  |
| spire-server.tornjak.startupProbe.initialDelaySeconds | int | `5` | Initial delay seconds for |
| spire-server.tornjak.startupProbe.periodSeconds | int | `10` |  |
| spire-server.tornjak.startupProbe.successThreshold | int | `1` |  |
| spire-server.tornjak.startupProbe.timeoutSeconds | int | `5` |  |
| spire-server.trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| spire-server.upstreamAuthority.certManager.enabled | bool | `false` |  |
| spire-server.upstreamAuthority.certManager.issuer_group | string | `"cert-manager.io"` |  |
| spire-server.upstreamAuthority.certManager.issuer_kind | string | `"Issuer"` |  |
| spire-server.upstreamAuthority.certManager.issuer_name | string | `"spire-ca"` |  |
| spire-server.upstreamAuthority.certManager.kube_config_file | string | `""` |  |
| spire-server.upstreamAuthority.certManager.namespace | string | `""` | Specify to use a namespace other then the one the chart is installed into |
| spire-server.upstreamAuthority.certManager.rbac.create | bool | `true` |  |
| spire-server.upstreamAuthority.disk.enabled | bool | `false` |  |
| spire-server.upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| spire-server.upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| spire-server.upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |
| spire-server.upstreamAuthority.spire.enabled | bool | `false` |  |
| spire-server.upstreamAuthority.spire.server.address | string | `""` |  |
| spire-server.upstreamAuthority.spire.server.port | int | `8081` |  |
| tornjak-frontend.affinity | object | `{}` |  |
| tornjak-frontend.apiServerURL | string | `"http://localhost:10000/"` | URL of the Tornjak APIs (backend) Since Tornjak Frontend runs in the browser, this URL must be accessible from the machine running a browser. |
| tornjak-frontend.fullnameOverride | string | `""` |  |
| tornjak-frontend.image.pullPolicy | string | `"IfNotPresent"` |  |
| tornjak-frontend.image.registry | string | `"ghcr.io"` |  |
| tornjak-frontend.image.repository | string | `"spiffe/tornjak-frontend"` |  |
| tornjak-frontend.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| tornjak-frontend.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tornjak-frontend.imagePullSecrets | list | `[]` |  |
| tornjak-frontend.labels | object | `{}` |  |
| tornjak-frontend.nameOverride | string | `""` |  |
| tornjak-frontend.namespaceOverride | string | `""` |  |
| tornjak-frontend.nodeSelector | object | `{"kubernetes.io/arch":"amd64"}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| tornjak-frontend.podSecurityContext | object | `{}` |  |
| tornjak-frontend.securityContext | object | `{}` |  |
| tornjak-frontend.service.annotations | object | `{}` |  |
| tornjak-frontend.service.port | int | `3000` |  |
| tornjak-frontend.service.type | string | `"ClusterIP"` |  |
| tornjak-frontend.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| tornjak-frontend.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| tornjak-frontend.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tornjak-frontend.spireHealthCheck.enabled | bool | `true` | Enables the SPIRE Healthchecker indicator |
| tornjak-frontend.startupProbe.enabled | bool | `true` | Enable startupProbe on Tornjak frontend container |
| tornjak-frontend.startupProbe.failureThreshold | int | `6` | Failure threshold count for startupProbe |
| tornjak-frontend.startupProbe.initialDelaySeconds | int | `5` | Initial delay seconds for startupProbe |
| tornjak-frontend.startupProbe.periodSeconds | int | `10` | Period seconds for startupProbe |
| tornjak-frontend.startupProbe.successThreshold | int | `1` | Success threshold count for startupProbe |
| tornjak-frontend.startupProbe.timeoutSeconds | int | `5` | Timeout seconds for startupProbe |
| tornjak-frontend.tolerations | list | `[]` |  |
| tornjak-frontend.topologySpreadConstraints | list | `[]` |  |

----------------------------------------------
