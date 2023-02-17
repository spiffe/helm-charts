# CONTRIBUTING

:tada: Thanks for your interest in contributing to this project. In this document we outline a few guidelines to ease the way your contributions flow into this project.

## Contributor guidelines and Governance

Please see [CONTRIBUTING](https://github.com/spiffe/spiffe/blob/main/CONTRIBUTING.md) and [GOVERNANCE](https://github.com/spiffe/spiffe/blob/main/GOVERNANCE.md) from the SPIFFE project.

In addition to those guidelines we also have a couple guidelines specifically tailored to make your contributions as smooth as possible to contribute Helm charts.

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
./helm-docs.sh charts/«chart-name»
```

[helm-docs]: https://github.com/norwoodj/helm-docs "Generate documentation for your Helm chart."
