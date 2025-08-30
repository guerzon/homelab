# homelab

## Terraform

GCP Modules, located here: <https://github.com/guerzon/terraform-modules-gcp>:

- [x] Registry
- [x] Network
- [x] Compute Engine
- [x] Certificate
- [x] ALB
- [x] Cloud SQL Instance
- [x] Database
- [x] Firewall
- [x] Cloud DNS zone
- [x] Cloud Armor
- [x] GKE Standard Cluster

## GKE workloads

### Applications

[Vaultwarden](./applications/vaultwarden/), using:

- [] Secrets Manager
- [x] Cloud SQL PostgreSQL, single-region
- [x] GKE Standard Cluster, single-region
- [x] Call [Helm chart](https://github.com/guerzon/vaultwarden)
- [x] Nginx Ingress
- [x] External-DNS

## DevOps tooling using Ansible

Fought the urge to create an Ansible role for each of these.

### Infra

- [x] PostgreSQL
- [-] JFrog Artifactory

### CI/CD

<https://dev.azure.com/lesterguerzon/DevOps>

### Security

- [-] Sonarqube

### Monitoring and alerting

- [x] Prometheus
- [-] Grafana
- [-] Elasticsearch
