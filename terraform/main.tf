
module "vpc" {
  source      = "git::https://github.com/guerzon/terraform-modules-gcp//network?ref=v1.2.0"
  environment = var.environment
  subnets = {
    main = {
      name       = "singapore-subnet"
      region     = var.region
      cidr_range = "10.0.0.0/16"
    }
  }
  create_ip = false
}

module "gke" {
  source               = "git::https://github.com/guerzon/terraform-modules-gcp//kubernetes?ref=v1.2.0"
  cluster_name         = "homelab"
  network              = module.vpc.network
  subnet               = "singapore-subnet"
  location             = var.preferred_zone # zonal cluster
  node_pool_type       = "preemptible"
  enable_private_nodes = true
  deletion_protection  = false
}

module "postgres" {
  source                      = "git::https://github.com/guerzon/terraform-modules-gcp//sqlinstance?ref=v1.2.0"
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
    var.my_ip
  ]
}

# Vaultwarden database
module "vaultwarden_db" {
  source            = "git::https://github.com/guerzon/terraform-modules-gcp//database?ref=v1.2.0"
  sql_instance_name = module.postgres.sql_instance_name
  database_name     = var.vaultwarden_database_name
  database_user     = var.vaultwarden_database_user
  database_password = var.vaultwarden_database_password
}

module "dns_zone" {
  source           = "git::https://github.com/guerzon/terraform-modules-gcp//dnszone?ref=v1.2.0"
  zone_name        = "homelab"
  zone_dns_name    = var.public_zone_dns
  zone_description = "Homelab DNS zone"
  zone_type        = "public"
  cloud_logging    = true
}

# module "dns_zone_private" {
#   source           = "git::https://github.com/guerzon/terraform-modules-gcp//dnszone?ref=v1.2.0"
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

# module "dns_record_1_1_1_1" {
#   source         = "git::https://github.com/guerzon/terraform-modules-gcp//dnsrecord?ref=v1.2.0"
#   managed_zone   = module.dns_zone.dns_zone
#   record_name    = "cooldns-${var.public_zone_dns}"
#   record_type    = "A"
#   record_content = ["1.1.1.1"]
#   record_ttl     = 60
# }