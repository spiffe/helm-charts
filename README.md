# SPIFFE Helm Charts

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)

A suite of [Helm Charts](https://helm.sh/docs) for standardized installations of SPIRE components in Kubernetes
environments.

## Add Helm repository

```bash
helm repo add spiffe https://spiffe.github.io/helm-charts/
helm repo update
```

## Dependencies and Version Compatibility

Unless otherwise noted in an application chart README, the following dependencies will follow these prescribed version
compatibility rules.

| Dependency | Supported Versions |
| :--------- | :----------------- |
| SPIRE      | `1.4.x`, `1.5.x`   |
| Helm       | `3.x`              |

For Kubernetes we will officially try to support the last 3 versions as described
in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions).

## SPIRE Server configuration support

| **Type**                       | **HPE** | **Phillips-labs** |
| ------------------------------ | :-----: | :---------------: |
| **Built-in plugins**           |         |                   |
| DataStore sqlite3              |   (?)   |        (✔)        |
| DataStore postgres             |   (?)   |        (✔)        |
| KeyManager aws_kms             |   (x)   |        (x)        |
| KeyManager disk                |   (✔)   |        (✔)        |
| KeyManager memory              |   (✔)   |        (x)        |
| NodeAttestor aws_iid           |   (x)   |        (x)        |
| NodeAttestor azure_msi         |   (x)   |        (x)        |
| NodeAttestor gcp_iit           |   (x)   |        (x)        |
| NodeAttestor join_token        |   (✔)   |        (x)        |
| NodeAttestor k8s_sat           |   (✔)   |        (x)        |
| NodeAttestor k8s_psat          |   (✔)   |        (✔)        |
| NodeAttestor sshpop            |   (x)   |        (x)        |
| NodeAttestor tpm_devid         |   (x)   |        (x)        |
| NodeAttestor x509pop           |   (x)   |        (x)        |
| Notifier gcs_bundle            |   (x)   |        (x)        |
| Notifier k8sbundle             |   (✔)   |        (✔)        |
| UpstreamAuthority disk         |   (✔)   |        (✔)        |
| UpstreamAuthority aws_pca      |   (x)   |        (x)        |
| UpstreamAuthority awssecret    |   (x)   |        (x)        |
| UpstreamAuthority gcp_cas      |   (x)   |        (x)        |
| UpstreamAuthority vault        |   (x)   |        (x)        |
| UpstreamAuthority spire        |   (✔)   |        (x)        |
| UpstreamAuthority cert-manager |   (x)   |        (x)        |
| **Server Configuration**       |         |                   |
| admin_ids                      |   (x)   |        (x)        |
| agent_ttl                      |   (x)   |        (x)        |
| audit_log_enabled              |   (x)   |        (x)        |
| bind_address                   |   (✔)   |        (x)        |
| bind_port                      |   (✔)   |        (x)        |
| ca_key_type                    |   (✔)   |        (x)        |
| ca_subject                     |   (✔)   |        (x)        |
| ca_ttl                         |   (✔)   |        (x)        |
| data_dir                       |   (✔)   |        (x)        |
| default_svid_ttl               |   (x)   |        (x)        |
| default_x509_svid_ttl          |   (✔)   |        (✔)        |
| default_jwt_svid_ttl           |   (✔)   |        (✔)        |
| experimental                   |   (x)   |        (x)        |
| federation                     |   (✔)   |        (x)        |
| jwt_key_type                   |   (✔)   |        (x)        |
| jwt_issuer                     |   (✔)   |        (✔)        |
| log_file                       |   (x)   |        (x)        |
| log_level                      |   (✔)   |        (✔)        |
| log_format                     |   (✔)   |        (x)        |
| omit_x509svid_uid              |   (x)   |        (x)        |
| profiling_enabled              |   (x)   |        (x)        |
| profiling_freq                 |   (x)   |        (x)        |
| profiling_names                |   (x)   |        (x)        |
| profiling_port                 |   (x)   |        (x)        |
| ratelimit                      |   (x)   |        (x)        |
| socket_path                    |   (✔)   |        (✔)        |
| trust_domain                   |   (✔)   |        (✔)        |
| **Telemetry**                  |         |                   |
| health_checks                  |   (✔)   |        (✔)        |
| Prometheus                     |   (x)   |        (x)        |
| DogStatsd                      |   (x)   |        (x)        |
| Statsd                         |   (x)   |        (x)        |
| M3                             |   (x)   |        (x)        |
| In-Mem                         |   (x)   |        (x)        |
| **k8s workload registrar**     |   (?)   |        (✔)        |
| **Controller Manager**         |   (✔)   |        (x)        |

## SPIRE Agent configuration support

| **Type**                        | **HPE** | **Phillips-labs** |
| ------------------------------- | :-----: | :---------------: |
| **Built-in plugins**            |         |                   |
| KeyManager disk                 |   (✔)   |        (x)        |
| KeyManager memory               |   (✔)   |        (✔)        |
| NodeAttestor aws_iid            |   (x)   |        (x)        |
| NodeAttestor azure_msi          |   (x)   |        (x)        |
| NodeAttestor gcp_iit            |   (x)   |        (x)        |
| NodeAttestor join_token         |   (✔)   |        (x)        |
| NodeAttestor k8s_sat            |   (✔)   |        (x)        |
| NodeAttestor k8s_psat           |   (✔)   |        (✔)        |
| NodeAttestor sshpop             |   (x)   |        (x)        |
| NodeAttestor x509pop            |   (x)   |        (x)        |
| WorkloadAttestor docker         |   (✔)   |        (x)        |
| WorkloadAttestor k8s            |   (✔)   |        (✔)        |
| WorkloadAttestor unix           |   (✔)   |        (✔)        |
| SVIDStore aws_secretsmanager    |   (x)   |        (x)        |
| SVIDStore gcp_secretmanager     |   (x)   |        (x)        |
| **Agent Configuration**         |         |                   |
| admin_socket_path               |   (x)   |        (x)        |
| allow_unauthenticated_verifiers |   (x)   |        (x)        |
| allowed_foreign_jwt_claims      |   (x)   |        (x)        |
| authorized_delegates            |   (x)   |        (x)        |
| data_dir                        |   (✔)   |        (✔)        |
| experimental                    |   (x)   |        (x)        |
| insecure_bootstrap              |   (x)   |        (x)        |
| join_token                      |   (x)   |        (x)        |
| log_file                        |   (x)   |        (x)        |
| log_level                       |   (✔)   |        (✔)        |
| log_format                      |   (x)   |        (x)        |
| profiling_enabled               |   (x)   |        (x)        |
| profiling_freq                  |   (x)   |        (x)        |
| profiling_names                 |   (x)   |        (x)        |
| profiling_port                  |   (x)   |        (x)        |
| server_address                  |   (✔)   |        (✔)        |
| server_port                     |   (✔)   |        (✔)        |
| socket_path                     |   (✔)   |        (✔)        |
| sds                             |   (✔)   |        (x)        |
| trust_bundle_path               |   (✔)   |        (x)        |
| trust_bundle_url                |   (x)   |        (x)        |
| trust_domain                    |   (✔)   |        (✔)        |
| workload_x509_svid_key_type     |   (x)   |        (x)        |
| **Telemetry**                   |         |                   |
| health_checks                   |   (✔)   |        (x)        |
| Prometheus                      |   (x)   |        (x)        |
| DogStatsd                       |   (x)   |        (x)        |
| Statsd                          |   (x)   |        (x)        |
| M3                              |   (x)   |        (x)        |
| In-Mem                          |   (x)   |        (x)        |
| **spiffe-csi-driver**           |   (✔)   |        (✔)        |

## Contributing

Before contributing ensure to check our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

## LICENSE

This project is licensed under [Apache License, Version 2.0](LICENSE).

## Reporting a Vulnerability

Vulnerabilities can be reported by sending an email to security@spiffe.io. A confirmation email will be sent to
acknowledge the report within 72 hours. A second acknowledgement will be sent within 7 days when the vulnerability has
been positively or negatively confirmed.
