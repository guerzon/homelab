## Resources specific to my GKE workloads
## - Cloud Router and NAT Gateway for outbound access
## - Cloud SQL PostgreSQL instance
## - GKE cluster with private preemptible nodes
## - Database instance for Vaultwarden
## - Helm release for Nginx ingress controller

module "router" {
  source      = "guerzon/gcp/modules//router"
  version     = "1.0.0"
  router_name = var.router_name
  network     = module.vpc.network_name
  region      = var.region
  bgp_asn     = 64600
}

module "nat_gateway" {
  source           = "guerzon/gcp/modules//natgateway"
  version          = "1.0.0"
  nat_gateway_name = "homelab-natgateway"
  router_name      = var.router_name
  region           = var.region
  network_tier     = "STANDARD"
}

module "postgres" {
  source                      = "guerzon/gcp/modules//sqlinstance"
  version                     = "1.0.0"
  instance_name               = "portfolio"
  database_version            = "POSTGRES_17"
  network_name                = module.vpc.network
  availability_type           = "ZONAL"
  region                      = "asia-southeast1"
  zone                        = "asia-southeast1-c"
  machine_type                = "db-custom-2-8192"
  deletion_protection_enabled = false
  retain_backups_on_delete    = false
  storage_size                = 10
  storage_autoresize          = true
  query_insights_enabled      = true
  storage_size_maximum        = 50
  authorized_networks = [
    {
      name    = "LesterIP"
      address = var.my_ip
    }
  ]
}

#################### Databases ####################

module "vaultwarden_db" {
  source            = "guerzon/gcp/modules//database"
  version           = "1.0.0"
  sql_instance_name = module.postgres.sql_instance_name
  database_name     = var.vaultwarden_database_name
  database_user     = var.vaultwarden_database_user
  database_password = var.vaultwarden_database_password
}

#################### GKE ####################

module "gke" {
  # source               = "guerzon/gcp/modules//kubernetes"
  # version              = "1.0.0"
  source               = "../../../Google-Cloud/terraform-modules-gcp/kubernetes"
  cluster_name         = "homelab"
  network              = module.vpc.network
  subnet               = "singapore-subnet"
  location             = var.preferred_zone # zonal cluster
  node_pool_type       = "preemptible"
  node_pool_count      = 2
  enable_private_nodes = true
  deletion_protection  = false
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
  ]
}

#################### Helm ####################

data "google_client_config" "default" {}

provider "helm" {
  kubernetes = {
    host                   = module.gke.cluster_endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}

resource "helm_release" "nginx_ingress_controller" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.13.0"

  cleanup_on_fail = true
  force_update    = true
  lint            = true

  depends_on = [module.nat_gateway]
}