# SPIRE Helm Charts Maintainership Guidelines and Processes

This document captures the values, guidelines, and processes that the SPIRE Helm Charts project and its maintainers adhere to. All maintainers agree to uphold and abide by the text contained herein.

For a list of active SPIRE Helm Charts maintainers, please see the [CODEOWNERS](CODEOWNERS) file.

## General governance

The SPIRE Helm CHarts project abides by the same [governance procedures][1] as the SPIFFE project, and ultimately reports to the [SPIFFE Steering Committee][3] (SSC) the same way that the SPIFFE project and associated maintainers do.

SSC members do not track day-to-day activity in the SPIFFE/SPIRE projects, and this should be considered when deciding to raise issues to them. While the SSC has the ultimate say, in practice they are only engaged upon serious maintainer disagreement.

## Maintainer responsibility

SPIRE maintainers adhere to the [requirements and responsibilities][2] set forth in the SPIFFE governance document. They further pledge the following:

* To act in the best interest of the project at all times.
* To ensure that project development and direction is a function of community needs.
* To never take any action while hesitant that it is the right action to take.
* To fulfill the responsibilities outlined in this document and its dependents.

## Guiding principles

The goal of this project is to deliver Helm Charts to the user that are stable, secure, and simple.

1. **Stability** -- The focus of this project is on stability over rapid feature development. SPIRE is a key infrastructure component that needs to be stable. While it is important to develop new features regularly, maintainers must take care that the project is stable.
1. **Security** -- SPIRE is a security solution. Maintainers will ensure that the helm charts are secure along with guidance on increasing security for production environments.
1. **Simplicity** -- Minimizing the options in the `values.yaml` files. Too many options can be confusing for the end user and we should limit options and to only expose configurations that are necessary. Its not possible to support every use case so we will select the use cases that are most important to the community.

It's easy to appreciate a technically advanced feature. It's harder to appreciate the absence of bugs, the slow but steady improvement in stability, or the reliability of a release process. But those things distinguish a good project from a great one.

## Feature development

Maintainers will maintain [milestones](https://github.com/spiffe/helm-charts/milestones) in GitHub as the roadmap to direct feature development. Maintainers will factor in open issues, PRs from the community, and their own judgement to determine the what is priority for the project. Maintainers will discuss these issues at bi-weekly sync meetings, offline on slack, and through discussion on the various issues and PRs. After discussing all the factors, the maintainers will decide on the milestones.

Maintainers will focus development and review efforts towards issues and PRs added in milestones, with the closest milestone getting the highest priority.

### Community PRs

For PRs that come in from the community the maintainers will discuss and determine if the PR is in line whith the project's [guiding principlies](#guiding-principles). If the PR is accepted to move forward the maintainers will add it to the appropriate mileston.

### Bug fixes

Bugs can be discovered at any time so its important to have flexibility to prioritize bug fixes as needed. Maintainers will discuss bug fixes received from the community, and if needed, can add them to a milestone to ensure they get reviewed and merged sooner. If maintainers discover bugs during the course of their work and the fix is simple, the maintainer is encouraged to submit a PR for it and discuss prioritizing it with the other maintainers. If a bug affects the security of the projects, maintainers must first discuss privately before fixing and disclosing.

## Changes in maintainership

### Appointing new maintainers

SPIRE Helm Charts maintainers are appointed according to the [process described in the governance document][2].

### Stepping down policy

Maintainers may step down at any time. After you've informed other maintainers, create a pull request to remove yourself from the [CODEOWNERS](CODEOWNERS) file.

### Removal of inactive maintainers

Existing maintainers can be removed from the list if they do not show significant activity on the project. Periodically, the maintainers review the list of maintainers and their activity over the last six months.

If a maintainer has shown insufficient activity over this period, the project manager will contact the maintainer to ask if they want to continue being a maintainer. If the maintainer decides to step down as a maintainer, they open a pull request to be removed from the [CODEOWNERS](CODEOWNERS) file.

If the maintainer wants to remain a maintainer, but is unable to perform the required duties they can be removed with a vote by the [SSC][3] and at least 66% of the current maintainers. A slack messages is sent to the maintainer channel, inviting maintainers of the project to vote. The voting period is five business days. Issues related to a maintainer's performance should be discussed with them among the other maintainers so that they aren't surprised by a pull request removing them.

[1]: https://github.com/spiffe/spiffe/blob/main/GOVERNANCE.md
[2]: https://github.com/spiffe/spiffe/blob/main/GOVERNANCE.md#maintainers
[3]: https://github.com/spiffe/spiffe/blob/main/GOVERNANCE.md#the-spiffe-steering-committee-ssc
