# SPIFFE Helm Charts

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development-) <!-- The - at the end of the URL is there on purpose -->

A suite of [Helm Charts](https://helm.sh/docs) for standardized installations of SPIRE components in Kubernetes environments.

A functioning SPIRE installation is composed of multiple interdependent components which can be installed and configured in a variety of ways. The Helm charts included in this repository exist to facilitate a standardized deployment of SPIRE within a Kubernetes environment under well-supported scenarios.

Each top-level chart directory contains a README describing the functionality and usage of that chart, as well as any customizations specific to the chart.

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

Published charts will be compatible with at least the current and previous minor versions of SPIRE at the time the charts were published. For example, if the current version of SPIRE is `1.5.1` then the charts published today will support SPIRE `1.5.x` and `1.4.x`. Other SPIRE versions may be supported, and will be explicitly listed if known.

## Contributing

Before contributing ensure to check our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

## LICENSE

This project is licensed under [Apache License, Version 2.0](LICENSE).

## Reporting a Vulnerability

Vulnerabilities can be reported by sending an email to security@spiffe.io. A confirmation email will be sent to acknowledge the report within 72 hours. A second acknowledgement will be sent within 7 days when the vulnerability has been positively or negatively confirmed.

## Conventions

This project will make every attempt to follow Helm's [Best Practices](https://helm.sh/docs/chart_best_practices/conventions/). If situations arise where conventional best practices will tend to put undo burden on the development or use of these charts then exceptions may be made and will be explicitly called out here (for all charts) or in a chart README (for chart specific exceptions).

### Application Charts

Each top-level application chart directory is a single installable unit supporting standard Helm commands like `install`, `upgrade`, `rollback`, and `uninstall`.

### Library Charts

Where appropriate, and to support shared common functionality between charts, [Helm library charts](https://helm.sh/docs/topics/library_charts/) will be created and utilized. Such a structure allows us to define standard SPIRE component installation and configuration settings while easily supporting customizations for specific install scenarios. Library charts are not themselves installable, but may be included as a dependency in other charts.

Library chart names will end with `-libchart`.

## Scope

SPIRE Helm Charts is intended to provide easily installable Helm charts for SPIRE Servers, Agents, and other relevant components. As such, the project will implement or has implemented charts for the following purposes.

### Currently In Scope

- Local, ephemeral, getting-to-know SPIRE setups
- Conventional single-cluster Kubernetes setups

### Eventually In Scope

- Conventional multi-cluster highly-available Kubernetes setups
- Conventional [Nested-SPIRE](https://spiffe.io/docs/latest/architecture/nested/readme/) Kubernetes setups
- Conventional public cloud setups (AWS, GCP, ...)

### Out of Scope

- Unconventional setups
- Non-kubernetes setups

## Communications

- Slack Channel: [#helm-charts](https://spiffe.slack.com/archives/C04BURZP1KK) in [SPIFFE](https://spiffe.slack.com) (Join [here](https://slack.spiffe.io)).
- User Mailing List: <user-discussion@spiffe.io> (View or join [here](https://groups.google.com/a/spiffe.io/forum/#!forum/user-discussion)).
- Developer Mailing List: <dev-discussion@spiffe.io> (View or join [here](https://groups.google.com/a/spiffe.io/forum/#!forum/dev-discussion)).
- Public Meeting Schedule and Links:
  - Calendar: [iCal & Browser-based TODO]
  - Meeting Notes: [Doc Link TODO]
  - Call Details: [Zoom Link TODO]
  - [Project Proposal](https://docs.google.com/document/d/197tavthpvdT0ZIElyX-07W8z7EgnMsWpwNH0WNs1p-Q/edit#heading=h.8uoj4iv7my5e)
