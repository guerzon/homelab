module "vpc" {
  source      = "guerzon/gcp/modules//network"
  version     = "1.3.0"
  environment = var.environment
}

module "subnets" {
  source  = "guerzon/gcp/modules//subnets"
  version = "1.3.0"
  network = module.vpc.network
  subnets = [
    {
      name       = var.region
      region     = var.region
      cidr_range = "10.0.0.0/16"
    }
  ]
}

module "dns_zone_sreafterhours" {
  source           = "guerzon/gcp/modules//dnszone"
  version          = "1.3.0"
  zone_name        = var.environment
  zone_dns_name    = "sreafterhours.dev."
  zone_description = "Delegated ${var.environment} DNS zone"
}