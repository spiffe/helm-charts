# SPIFFE Helm Charts

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)

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
| SPIRE      | `1.4.x`, `1.5.x`   |
| Helm       | `3.x`              |

For Kubernetes we will officially try to support the last 3 versions as described in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions).

## Contributing

Before contributing ensure to check our [CONRIBUTING](CONTRIBUTING.md) guidelines.

## LICENSE

This project is licensed under [Apache License, Version 2.0](LICENSE).

## Reporting a Vulnerability

Vulnerabilities can be reported by sending an email to security@spiffe.io. A confirmation email will be sent to acknowledge the report within 72 hours. A second acknowledgement will be sent within 7 days when the vulnerability has been positively or negatively confirmed.