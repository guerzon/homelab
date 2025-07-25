data "google_client_config" "default" {}

provider "helm" {
  kubernetes = {
    host                   = module.gke.cluster_endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}

# resource "helm_release" "nginx_ingress_controller" {
#   name             = "ingress-nginx"
#   repository       = "https://kubernetes.github.io/ingress-nginx"
#   chart            = "ingress-nginx"
#   namespace        = "ingress-nginx"
#   create_namespace = true
#   version          = "4.13.0"

#   cleanup_on_fail = true
#   force_update    = true
#   lint            = true

#   depends_on = [module.nat_gateway]
# }