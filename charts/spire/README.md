# spire

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.0](https://img.shields.io/badge/AppVersion-1.5.0-informational?style=flat-square)

A Helm chart for deploying spire-server and spire-agent.

> :warning: Please note this chart requires Projected Service Account Tokens which has to be enabled on your k8s api server.

> :warning: Minimum Spire version is `v1.0.2`.

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

**Homepage:** <https://github.com/philips-labs/helm-charts/charts/spire>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |

## Source Code

* <https://github.com/philips-labs/helm-charts/charts/spire>

## Requirements

Kubernetes: `>=1.21.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| agent.image.pullPolicy | string | `"IfNotPresent"` |  |
| agent.image.registry | string | `"ghcr.io"` |  |
| agent.image.repository | string | `"spiffe/spire-agent"` |  |
| agent.image.version | string | `""` |  |
| agent.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| agent.resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| csiDriver.image.pullPolicy | string | `"IfNotPresent"` |  |
| csiDriver.image.registry | string | `"ghcr.io"` |  |
| csiDriver.image.repository | string | `"spiffe/spiffe-csi-driver"` |  |
| csiDriver.image.version | string | `"0.2.0"` |  |
| csiDriver.resources | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeDriverRegistrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| nodeDriverRegistrar.image.registry | string | `"quay.io"` |  |
| nodeDriverRegistrar.image.repository | string | `"k8scsi/csi-node-driver-registrar"` |  |
| nodeDriverRegistrar.image.version | string | `"v2.0.1"` |  |
| nodeDriverRegistrar.resources | object | `{}` |  |
| oidc.acme.cacheDir | string | `"/run/spire"` |  |
| oidc.acme.directoryUrl | string | `"https://acme-v02.api.letsencrypt.org/directory"` |  |
| oidc.acme.emailAddress | string | `"letsencrypt@example.org"` |  |
| oidc.acme.tosAccepted | bool | `false` |  |
| oidc.domains[0] | string | `"localhost"` |  |
| oidc.domains[1] | string | `"spire-oidc.spire"` |  |
| oidc.domains[2] | string | `"spire-oidc.spire.svc.cluster.local"` |  |
| oidc.domains[3] | string | `"oidc-discovery.example.org"` |  |
| oidc.enabled | bool | `false` |  |
| oidc.image.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.image.registry | string | `"ghcr.io"` |  |
| oidc.image.repository | string | `"spiffe/spire-oidc-provider"` |  |
| oidc.image.version | string | `""` |  |
| oidc.insecureScheme.enabled | bool | `false` |  |
| oidc.insecureScheme.nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| oidc.insecureScheme.nginx.image.registry | string | `"docker.io"` |  |
| oidc.insecureScheme.nginx.image.repository | string | `"nginx"` |  |
| oidc.insecureScheme.nginx.image.version | string | `"alpine"` |  |
| oidc.jwtIssuer | string | `"oidc-discovery.example.org"` |  |
| oidc.logLevel | string | `"INFO"` |  |
| oidc.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| oidc.resources | object | `{}` |  |
| oidc.service.annotations | object | `{}` |  |
| oidc.service.port | int | `80` |  |
| oidc.service.type | string | `"NodePort"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| securityContext | object | `{}` |  |
| server.dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.dataStorage.enabled | bool | `true` |  |
| server.dataStorage.size | string | `"1Gi"` |  |
| server.dataStorage.storageClass | string | `nil` |  |
| server.image.pullPolicy | string | `"IfNotPresent"` |  |
| server.image.registry | string | `"ghcr.io"` |  |
| server.image.repository | string | `"spiffe/spire-server"` |  |
| server.image.version | string | `""` |  |
| server.nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| server.resources | object | `{}` |  |
| server.service.port | int | `8081` |  |
| server.service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| spire.agent.logLevel | string | `"info"` |  |
| spire.clusterName | string | `"example-cluster"` |  |
| spire.server.logLevel | string | `"info"` |  |
| spire.trustDomain | string | `"example.org"` |  |
| tolerations | list | `[]` |  |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` |  |
| waitForIt.image.registry | string | `"gcr.io"` |  |
| waitForIt.image.repository | string | `"spiffe-io/wait-for-it"` |  |
| waitForIt.image.version | string | `""` |  |
| workloadRegistrar.image.pullPolicy | string | `"IfNotPresent"` |  |
| workloadRegistrar.image.registry | string | `"gcr.io"` |  |
| workloadRegistrar.image.repository | string | `"spiffe-io/k8s-workload-registrar"` |  |
| workloadRegistrar.image.version | string | `""` |  |
| workloadRegistrar.resources | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
