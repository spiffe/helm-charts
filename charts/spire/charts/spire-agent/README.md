# spire-agent

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.5.4](https://img.shields.io/badge/AppVersion-1.5.4-informational?style=flat-square)

A Helm chart to install the SPIRE agent.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterName | string | `"example-cluster"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` |  |
| image.repository | string | `"spiffe/spire-agent"` |  |
| image.version | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| logLevel | string | `"info"` |  |
| nameOverride | string | `""` |  |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| server.port | int | `8081` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| trustDomain | string | `"example.org"` |  |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` |  |
| waitForIt.image.registry | string | `"cgr.dev"` |  |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` |  |
| waitForIt.image.version | string | `"latest-20230113"` |  |
| waitForIt.resources | object | `{}` |  |
| workloadAttestors.unix | object | `{"enabled":false}` | unix is a workload attestor which generates unix-based selectors like 'uid' and 'gid'. |

----------------------------------------------
