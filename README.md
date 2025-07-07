# homelab

## Terraform

Modules:

- [x] Network
- [x] Compute Engine
- [x] Certificate
- [x] ALB
- [x] PostgreSQL
- [x] Firewall
- [] Cloud DNS zone
- [x] Cloud Armor
- [] GKE Standard Cluster

## GKE workloads

### Management

- [] Jenkins
- [] ArgoCD

### Monitoring and alerting

- [] Prometheus
- [] Grafana

### Applications

Vaultwarden, using:

- [] Secrets Manager
- [] Cloud SQL PostgreSQL, single-region
- [] GKE Standard Cluster, single-region
- [] Call [Helm chart](https://github.com/guerzon/vaultwarden)
- [] Nginx Ingress
- [] DNS
