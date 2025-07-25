# module "vpc" {
#   source = "guerzon/gcp/modules//network"
#   version = "1.0.0"
#   environment = var.environment
# }
# 
# module "subnet" {
#   source = "guerzon/gcp/modules//subnets"
#   version = "1.0.0"
#   network = module.vpc.network
#   subnets = [
#     {
#       name       = "singapore-subnet"
#       region     = var.region
#       cidr_range = "10.0.0.0/16"
#     }
#   ]
# }

# module "dns_zone_private" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//dnszone"
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

# module "router" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//router"
#   source      = "../../../Google-Cloud/terraform-modules-gcp/router"
#   router_name = var.router_name
#   network     = module.vpc.network_name
#   region      = var.region
#   bgp_asn     = 64600
# }

# module "nat_gateway" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//natgateway"
#   source           = "../../../Google-Cloud/terraform-modules-gcp/natgateway"
#   nat_gateway_name = "homelab-natgateway"
#   router_name      = var.router_name
#   region           = var.region
#   network_tier     = "STANDARD"
# }