## - VPC and subnet in Singapore region
## - Cloud Router and NAT Gateway for outbound access

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
      name       = "${var.region}-subnet"
      region     = var.region
      cidr_range = "10.0.0.0/16"
    }
  ]
}

module "router" {
  source      = "guerzon/gcp/modules//router"
  version     = "1.0.0"
  router_name = "${var.region}-router"
  network     = module.vpc.network_name
  region      = var.region
  bgp_asn     = 64600
}

module "nat_gateway" {
  source           = "guerzon/gcp/modules//natgateway"
  version          = "1.0.0"
  nat_gateway_name = "${var.region}-ngw"
  router_name      = "${var.region}-router"
  region           = var.region
  network_tier     = "STANDARD"
  depends_on       = [module.router]
}