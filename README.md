> **Note**: All the helm charts in this repo are beta. We encourage you to try them out and contribute. The API may change as we move towards a production ready release.

# SPIFFE Helm Charts

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts)](https://opensource.org/licenses/Apache-2.0)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/spiffe)](https://artifacthub.io/packages/search?repo=spiffe)

A suite of [Helm Charts](https://helm.sh/docs) for standardized installations of SPIRE components in Kubernetes environments.

## Add Helm repository

```bash
helm repo add spiffe https://spiffe.github.io/helm-charts/
helm repo update
```

## Dependencies and Version Compatibility

Unless otherwise noted in an application chart README, the following dependencies will follow these prescribed version compatibility rules.

| Dependency | Supported Versions |
|:-----------|:-------------------|
| SPIRE      | `1.5.3`+, `1.6.x`  |
| Helm       | `3.x`              |
| Kubernetes | `1.21+`            |

> **Note**: For Kubernetes, we will officially support the last 3 versions as described in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions). Any version before the last 3 we will try to support as long it doesn't bring security issues or any big maintenance burden. *The first version we tested this chart with is `1.21`.*

## Contributing

Before contributing ensure to check our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

## LICENSE

This project is licensed under [Apache License, Version 2.0](LICENSE).

## Reporting a Vulnerability

Vulnerabilities can be reported by sending an email to security@spiffe.io. A confirmation email will be sent to acknowledge the report within 72 hours. A second acknowledgement will be sent within 7 days when the vulnerability has been positively or negatively confirmed.
