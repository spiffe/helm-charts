# spire

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.5](https://img.shields.io/badge/AppVersion-1.5.5-informational?style=flat-square)

A Helm chart for deploying the complete Spire stack including: spire-server, spire-agent, spiffe-csi-driver, spiffe-oidc-discovery-provider and spire-controller-manager.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Warning**: Please note this chart requires Projected Service Account Tokens which has to be enabled on your k8s api server.

> **Note**: Minimum Spire version is `v1.5.3`.

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

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Requirements

Kubernetes: `>=1.21.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://./charts/spiffe-csi-driver | spiffe-csi-driver | 0.1.0 |
| file://./charts/spiffe-oidc-discovery-provider | spiffe-oidc-discovery-provider | 0.1.0 |
| file://./charts/spire-agent | spire-agent | 0.1.0 |
| file://./charts/spire-server | spire-server | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| spiffe-csi-driver.enabled | bool | `true` |  |
| spiffe-oidc-discovery-provider.enabled | bool | `false` |  |
| spiffe-oidc-discovery-provider.trustDomain | string | `"example.org"` |  |
| spire-agent.bundleConfigMap | string | `"spire-bundle"` |  |
| spire-agent.clusterName | string | `"example-cluster"` |  |
| spire-agent.enabled | bool | `true` |  |
| spire-agent.nameOverride | string | `"agent"` |  |
| spire-agent.trustDomain | string | `"example.org"` |  |
| spire-server.bundleConfigMap | string | `"spire-bundle"` |  |
| spire-server.clusterName | string | `"example-cluster"` |  |
| spire-server.controllerManager.enabled | bool | `true` |  |
| spire-server.enabled | bool | `true` |  |
| spire-server.nameOverride | string | `"server"` |  |
| spire-server.trustDomain | string | `"example.org"` |  |

----------------------------------------------
