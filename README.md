# homelab

## Terraform

Modules, located here: <https://github.com/guerzon/terraform-modules-gcp>:

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

### Management

- [] Jenkins
- [] ArgoCD

### Monitoring and alerting

- [] Prometheus
- [] Grafana

### Applications

[Vaultwarden](./applications/vaultwarden/), using:

- [] Secrets Manager
- [x] Cloud SQL PostgreSQL, single-region
- [x] GKE Standard Cluster, single-region
- [x] Call [Helm chart](https://github.com/guerzon/vaultwarden)
- [] Nginx Ingress
- [] DNS
