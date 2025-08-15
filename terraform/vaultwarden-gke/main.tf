data "terraform_remote_state" "common_gcp" {
  backend = "gcs"
  config = {
    bucket = "terraform-gcp-portfolio-465603"
    prefix = "terraform/common"
  }
}

module "gke" {
  source               = "guerzon/gcp/modules//kubernetes"
  version              = "1.3.0"
  cluster_name         = "homelab"
  network              = data.terraform_remote_state.common_gcp.outputs.vpc_network
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
  project_id = var.project_id
  roles = [
    "roles/dns.admin"
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
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.18.0"

  cleanup_on_fail = true
  force_update    = true
  lint            = true

  set = [
    { name = "provider.name", value = "google" },
    { name = "domainFilters[0]", value = var.public_zone_dns },
  ]

}