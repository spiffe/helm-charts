# tornjak-frontend

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.2.0](https://img.shields.io/badge/AppVersion-v1.2.0-informational?style=flat-square)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)

A Helm chart to deploy Tornjak frontend

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Version support

> **Note**: This Chart is still in development and still subject to change the API (`values.yaml`).
> Until we reach a `1.0.0` version of the chart we can't guarantee backwards compatibility although
> we do aim for as much stability as possible.

| Dependency | Supported Versions |
|:-----------|:-------------------|
| SPIRE      | `1.5.3+`, `1.6.x`  |
| Tornjak    | `1.0.x`            |
| Helm       | `3.x`              |

## Prerequisites

This chart requires access to Tornjak Backend (`tornjakFrontend.apiServerURL`).
This URL needs to be reachable from your web browser and can therefore not be a cluster internal URL.

Obtain the URL for Tornjak APIs. If deployed in the same cluster, locally,
Tornjak APIs are typically available at `http://localhost:10000`.
Review Tornjak documentation for more details.

## Usage

Since this is just a demo version, to access Tornjak APIs you can use
port forwarding. See the chart NOTES output for more details.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mrsabath | <mrsabath@gmail.com> | <https://mrsabath.github.io> |

## Source Code

* <https://github.com/spiffe/tornjak>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| apiServerURL | string | `"http://localhost:10000/"` | URL of the Tornjak APIs (backend) Since Tornjak Frontend runs in the browser, this URL must be accessible from the machine running a browser. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/tornjak-frontend"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| imagePullSecrets | list | `[]` |  |
| labels | object | `{}` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| nodeSelector | object | `{"kubernetes.io/arch":"amd64"}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| spireHealthCheck.enabled | bool | `true` | Enables the SPIRE Healthchecker indicator |
| tests.bash.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| tests.bash.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| tests.bash.image.repository | string | `"chainguard/bash"` | The repository within the registry |
| tests.bash.image.tag | string | `"latest-20230517"` | Overrides the image tag |
| tests.bash.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
----------------------------------------------
