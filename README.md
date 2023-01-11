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
|:-----------|:-------------------|
| SPIRE      | `1.4.x`, `1.5.x`   |
| Helm       | `3.x`              |

For Kubernetes we will officially try to support the last 3 versions as described
in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions).

## SPIRE Server configuration support

| **Type**                 |                                                               **HPE**                                                                | **Phillips-labs** |
|--------------------------|:------------------------------------------------------------------------------------------------------------------------------------:|:-----------------:|
| **Built-in plugins**     |                                                                                                                                      |                   |
| DataStore                |                                                               sql (✔)                                                                |         -         |
| KeyManager               |                                                  aws_kms (x), disk (✔), memory (✔)                                                   |         -         |
| NodeAttestor             | aws_iid (x), azure_msi (x), gcp_iit (x),<br/> join_token (✔), k8s_sat (✔), k8s_psat (✔),<br/> sshpop (x), tpm_devid (x), x509pop (x) |         -         |
| Notifier                 |                                                    gcs_bundle (x), k8sbundle (✔)                                                     |         -         |
| UpstreamAuthority        |                    disk (✔), aws_pca (x), awssecret (x),<br/> gcp_cas (x), vault (x), spire (✔), cert-manager (x)                    |         -         |
| **Server Configuration** |                                                                                                                                      |                   |
| admin_ids                |                                                                 (x)                                                                  |         -         |
| agent_ttl                |                                                                 (x)                                                                  |         -         |
| audit_log_enabled        |                                                                 (x)                                                                  |         -         |
| bind_address             |                                                                 (✔)                                                                  |         -         |
| bind_port                |                                                                 (✔)                                                                  |         -         |
| ca_key_type              |                                                                 (✔)                                                                  |         -         |
| ca_subject               |                                                                 (✔)                                                                  |         -         |
| ca_ttl                   |                                                                 (✔)                                                                  |         -         |
| data_dir                 |                                                                 (✔)                                                                  |         -         |
| default_svid_ttl         |                                                                 (x)                                                                  |         -         |
| default_x509_svid_ttl    |                                                                 (✔)                                                                  |         -         |
| default_jwt_svid_ttl     |                                                                 (✔)                                                                  |         -         |
| experimental             |                                                                 (x)                                                                  |         -         |
| federation               |                                                                 (✔)                                                                  |         -         |
| jwt_key_type             |                                                                 (✔)                                                                  |         -         |
| jwt_issuer               |                                                                 (✔)                                                                  |         -         |
| log_file                 |                                                                 (x)                                                                  |         -         |
| log_level                |                                                                 (✔)                                                                  |         -         |
| log_format               |                                                                 (✔)                                                                  |         -         |
| omit_x509svid_uid        |                                                                 (x)                                                                  |         -         |
| profiling_enabled        |                                                                 (x)                                                                  |         -         |
| profiling_freq           |                                                                 (x)                                                                  |         -         |
| profiling_names          |                                                                 (x)                                                                  |         -         |
| profiling_port           |                                                                 (x)                                                                  |         -         |
| ratelimit                |                                                                 (x)                                                                  |         -         |
| socket_path              |                                                                 (✔)                                                                  |         -         |
| trust_domain             |                                                                 (✔)                                                                  |         -         |
| **Telemetry**            |                                                                 (✔)                                                                  |         -         |
| health_checks            |                                                                 (✔)                                                                  |         -         |
| Prometheus               |                                                                 (x)                                                                  |         -         |
| DogStatsd                |                                                                 (x)                                                                  |         -         |
| Statsd                   |                                                                 (x)                                                                  |         -         |
| M3                       |                                                                 (x)                                                                  |         -         |
| In-Mem                   |                                                                 (x)                                                                  |         -         |
| **Controller Manager**   |                                                                 (✔)                                                                  |         -         |

## SPIRE Agent configuration support

| **Type**                        |                                                       **HPE**                                                        | **Phillips-labs** |
|---------------------------------|:--------------------------------------------------------------------------------------------------------------------:|:-----------------:|
| **Built-in plugins**            |                                                                                                                      |                   |
| KeyManager                      |                                                 disk (✔), memory (✔)                                                 |         -         |
| NodeAttestor                    | aws_iid (x), azure_msi (x), gcp_iit (x),<br/> join_token (✔), k8s_sat (✔), k8s_psat (✔)<br/> sshpop (x), x509pop (x) |         -         |
| WorkloadAttestor                |                                            docker (✔), k8s (✔), unix (✔)                                             |         -         |
| SVIDStore                       |                                    aws_secretsmanager (x), gcp_secretmanager (x)                                     |         -         |
| **Agent Configuration**         |                                                                                                                      |                   |
| admin_socket_path               |                                                         (x)                                                          |         -         |
| allow_unauthenticated_verifiers |                                                         (x)                                                          |         -         |
| allowed_foreign_jwt_claims      |                                                         (x)                                                          |         -         |
| authorized_delegates            |                                                         (x)                                                          |         -         |
| data_dir                        |                                                         (✔)                                                          |         -         |
| experimental                    |                                                         (x)                                                          |         -         |
| insecure_bootstrap              |                                                         (x)                                                          |         -         |
| join_token                      |                                                         (x)                                                          |         -         |
| log_file                        |                                                         (x)                                                          |         -         |
| log_level                       |                                                         (✔)                                                          |         -         |
| log_format                      |                                                         (x)                                                          |         -         |
| profiling_enabled               |                                                         (x)                                                          |         -         |
| profiling_freq                  |                                                         (x)                                                          |         -         |
| profiling_names                 |                                                         (x)                                                          |         -         |
| profiling_port                  |                                                         (x)                                                          |         -         |
| server_address                  |                                                         (✔)                                                          |         -         |
| server_port                     |                                                         (✔)                                                          |         -         |
| socket_path                     |                                                         (✔)                                                          |         -         |
| sds                             |                                                         (✔)                                                          |         -         |
| trust_bundle_path               |                                                         (✔)                                                          |         -         |
| trust_bundle_url                |                                                         (x)                                                          |         -         |
| trust_domain                    |                                                         (✔)                                                          |         -         |
| workload_x509_svid_key_type     |                                                         (x)                                                          |         -         |
| **Telemetry**                   |                                                         (✔)                                                          |         -         |
| health_checks                   |                                                         (✔)                                                          |         -         |
| Prometheus                      |                                                         (x)                                                          |         -         |
| DogStatsd                       |                                                         (x)                                                          |         -         |
| Statsd                          |                                                         (x)                                                          |         -         |
| M3                              |                                                         (x)                                                          |         -         |
| In-Mem                          |                                                         (x)                                                          |         -         |
| **spiffe-csi-driver**           |                                                         (✔)                                                          |         -         |

## Contributing

Before contributing ensure to check our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

## LICENSE

This project is licensed under [Apache License, Version 2.0](LICENSE).

## Reporting a Vulnerability

Vulnerabilities can be reported by sending an email to security@spiffe.io. A confirmation email will be sent to
acknowledge the report within 72 hours. A second acknowledgement will be sent within 7 days when the vulnerability has
been positively or negatively confirmed.
