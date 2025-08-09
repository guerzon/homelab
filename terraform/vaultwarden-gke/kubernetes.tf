## Resources specific to my GKE workloads
## - Helm release for Nginx ingress controller

module "gke" {
  source               = "guerzon/gcp/modules//kubernetes"
  version              = "1.1.0"
  cluster_name         = "homelab"
  network              = module.vpc.network
  subnet               = "${var.region}-subnet"
  location             = var.preferred_zone # zonal cluster
  node_pool_type       = "preemptible"
  node_pool_count      = 2
  enable_private_nodes = true
  deletion_protection  = false
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
  ]
  depends_on = [
    module.subnet
  ]
}

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