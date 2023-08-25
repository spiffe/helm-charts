# tornjak-frontend

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.2.2](https://img.shields.io/badge/AppVersion-v1.2.2-informational?style=flat-square)
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

## Tornjak

Tornjak is the UI and Control Plane for SPIRE [https://github.com/spiffe/tornjak](https://github.com/spiffe/tornjak) and it is composed of two components:

* [Backend](../spire-server/README.md) - Tornjak APIs that extend SPIRE APIs with Control Plane functionality
* Frontend (this chart) - Tornjak UI

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

## Parameters
