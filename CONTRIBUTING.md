# CONTRIBUTING

:tada: Thanks for your interest in contributing to this project. In this document we outline a few guidelines to ease the way your contributions flow into this project.

## Contributor guidelines and Governance

Please see [CONTRIBUTING](https://github.com/spiffe/spiffe/blob/main/CONTRIBUTING.md) and [GOVERNANCE](https://github.com/spiffe/spiffe/blob/main/GOVERNANCE.md) from the SPIFFE project.

In addition to those guidelines we also have a couple guidelines specifically tailored to make your contributions as smooth as possible to contribute Helm charts.

- Use [GitHub Issues](https://github.com/spiffe/helm-charts/issues) to request features or file bugs.

## Prerequisites

- **Helm 3** or higher (<https://helm.sh/docs/intro/install/>)

## Commit style

Ensure you have clear and concise commits, written in the present tense. See [Kubernetes commit message guidelines](https://www.kubernetes.dev/docs/guide/pull-requests/#commit-message-guidelines) for a more detailed explanation of our approach.

```diff
+ git commit -m "Bump spire appVersion 1.4.4"
- git commit -m "Bumped spire appVersion 1.4.4"
```

## PRs

Stick with one feature/chart per branch. This allows us to make small controlled releases of the charts without blocking other chart releases in case of issues releasing a chart.

Ensure your branch is rebased on top of main before issuing your PR. This to keep a clean Git history and to ensure your changes are working with the latest main branch changes.

```bash
git checkout main
git pull
git checkout «your-branch»
git rebase main
```

## Generating documentation

Any changes to Chart.yaml or values.yaml require an update of the README.md. This update can easily be generated using [helm-docs][].

```shell
helm-docs -g charts/«chart-name» -t .github/README.md.tmpl
```

## Building

A Makefile is provided for common actions.

- `make` - [describe action TODO]
- `make all` - [describe action TODO]
- `make lint` - [describe action TODO]
- `make test` - runs unit tests

See `make help` for other targets

The Makefile takes care of installing the required toolchain as needed. The toolchain and other build related files are cached under the `.build` folder (ignored by git).

## Conventions

In addition to the conventions covered in the SPIFFE project's [CONTRIBUTING](https://github.com/spiffe/spiffe/blob/main/CONTRIBUTING.md), the following conventions apply to the SPIRE Helm Charts repository:

### Chart names

All chart names will begin with either `spiffe-` or `spire-` followed by a descriptive component name. Library charts will end with `-libchart`.

#### Examples

| Name                    | Type        | Good For                | Meaning                                                                                                           |
|:------------------------|:------------|:------------------------|:------------------------------------------------------------------------------------------------------------------|
| `spire-ephemeral`       | Application | Getting to know SPIRE   | An installable chart that will configure both SPIRE Server and Agent in a localized, ephemeral, and non-HA setup. |
| `spire-agent`       | Application | Standard K8s environment | An installable chart that will configure SPIRE Agents for a standard Kubernetes environment.                      |
| `spire-server`      | Application | Standard K8s environment | An installable chart that will configure SPIRE Servers for a standard Kubernetes environment.                     |
| `spiffe-csi`        | Application | Standard K8s environment | An installable chart that will install the SPIFFE CSI Driver in a standard Kubernetes environment.                |
| `spire-agent-aws`       | Application | AWS K8s environment     | An installable chart that will configure SPIRE Agents for an AWS Kubernetes environment.                          |
| `spire-k8s-libchart`    | Library     |                         | A library chart providing recommended setup and configuration in a standard Kubernetes environment.               |
| `spire-aws-libchart`    | Library     |                         | A library chart providing recommended setup and configuration in a standard AWS environment.                      |
| `spire-agent-libchart`  | Library     |                         | A library chart providing recommended setup and configuration for a SPIRE Agent.                                  |
| `spire-server-libchart` | Library     |                         | A library chart providing recommended setup and configuration for a SPIRE Server.                                 |

### Directory layout

`/charts/<chart name>/`

Every chart will exist in a top-level directory matching the chart name and should follow standard [Helm directory structure](https://helm.sh/docs/topics/charts/#the-chart-file-structure), except where indicated below.

| Path                               | Difference                                                                     |
|:-----------------------------------|:-------------------------------------------------------------------------------|
| `/charts/<chart name>/README.md`          | Required                                                                       |
| `/charts/<chart name>/LICENSE`            | Disallowed. The root [LICENSE](/LICENSE) will be copied in during publish time |
| `/charts/<chart name>/values.schema.json` | Required in Application charts                                                 |
| `/charts/<chart name>/charts/`            | Disallowed. Dependencies should be listed in `Chart.yaml`                      |

## Reporting security vulnerabilities

If you've found a vulnerability or a potential vulnerability in SPIRE please let us know at security@spiffe.io. We'll send a confirmation email to acknowledge your report, and we'll send an additional email when we've identified the issue positively or negatively.

[helm-docs]: https://github.com/norwoodj/helm-docs "Generate documentation for your Helm chart."
