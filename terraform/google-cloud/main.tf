module "vpc" {
  source      = "guerzon/gcp/modules//network"
  version     = "1.0.0"
  environment = var.environment
}

module "subnet" {
  source  = "guerzon/gcp/modules//subnets"
  version = "1.0.0"
  network = module.vpc.network
  subnets = [
    {
      name       = "singapore-subnet"
      region     = var.region
      cidr_range = "10.0.0.0/16"
    }
  ]
}

# module "dns_zone_private" {
#   source           = "../../../Google-Cloud/terraform-modules-gcp/dnszone"
#   zone_name        = "hideout"
#   zone_dns_name    = var.private_zone_dns
#   zone_description = "Hideout DNS zone"
#   zone_type        = "private"
#   cloud_logging    = true
#   visible_networks = [
#     module.vpc.network
#   ]
#   visible_gke_clusters = [
#     module.gke.cluster_id
#   ]
# }