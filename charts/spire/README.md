# spire

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.6.3](https://img.shields.io/badge/Version-0.6.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.3](https://img.shields.io/badge/AppVersion-1.6.3-informational?style=flat-square)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)

A Helm chart for deploying the complete Spire stack including: spire-server, spire-agent, spiffe-csi-driver, spiffe-oidc-discovery-provider and spire-controller-manager.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Version support

> **Note**: This Chart is still in development and still subject to change the API (`values.yaml`).
> Until we reach a `1.0.0` version of the chart we can't guarantee backwards compatibility although
> we do aim for as much stability as possible.

| Dependency | Supported Versions |
|:-----------|:-------------------|
| SPIRE      | `1.5.3+`, `1.6.x`  |
| Helm       | `3.x`              |
| Kubernetes | `1.21+`            |

> **Note**: For Kubernetes, we will officially support the last 3 versions as described in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions). Any version before the last 3 we will try to support as long it doesn't bring security issues or any big maintenance burden. *The first version we tested this chart with is `1.21`.*

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
| global.k8s.clusterDomain | string | `"cluster.local"` |  |
| global.spire.bundleConfigMap | string | `""` | Override all instances of bundleConfigMap |
| global.spire.clusterName | string | `"example-cluster"` | Set the name of the Kubernetes cluster |
| global.spire.trustDomain | string | `"example.org"` | Set the trust domain to use for the spiffe identifiers |
| nameOverride | string | `""` |  |
| spiffe-csi-driver.enabled | bool | `true` |  |
| spiffe-oidc-discovery-provider.enabled | bool | `false` |  |
| spire-agent.enabled | bool | `true` |  |
| spire-agent.nameOverride | string | `"agent"` |  |
| spire-server.controllerManager.enabled | bool | `true` |  |
| spire-server.enabled | bool | `true` |  |
| spire-server.nameOverride | string | `"server"` |  |

----------------------------------------------
