module "vpc" {
  source      = "guerzon/gcp/modules//network"
  version     = "1.3.0"
  environment = var.environment
}

module "subnet" {
  source  = "guerzon/gcp/modules//subnets"
  version = "1.3.0"
  network = module.vpc.network
  subnets = [
    {
      name       = "singapore-subnet"
      region     = var.region
      cidr_range = "10.0.0.0/16"
    }
  ]
}

module "dns_zone" {
  source           = "guerzon/gcp/modules//dnszone"
  version          = "1.3.0"
  zone_name        = var.environment
  zone_dns_name    = var.public_zone_dns
  zone_description = "Homelab DNS zone"
  zone_type        = "public"
  cloud_logging    = true
}