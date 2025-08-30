# module "router" {
#   source      = "guerzon/gcp/modules//router"
#   version     = "1.3.0"
#   router_name = "${var.environment}-router"
#   network     = module.vpc.network_name
#   region      = var.region
#   bgp_asn     = 64600
# }

# module "nat_gateway" {
#   source           = "guerzon/gcp/modules//natgateway"
#   version          = "1.3.0"
#   nat_gateway_name = "${var.environment}-natgateway"
#   router_name      = "${var.environment}-router"
#   region           = var.region
#   network_tier     = "STANDARD"
# }