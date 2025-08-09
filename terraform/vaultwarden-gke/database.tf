## - Cloud SQL PostgreSQL instance
## - Database instance for Vaultwarden

module "postgres" {
  source                      = "guerzon/gcp/modules//sqlinstance"
  version                     = "1.1.1"
  instance_name               = "portfolio"
  database_version            = "POSTGRES_17"
  network_name                = module.vpc.network
  availability_type           = "ZONAL"
  region                      = var.region
  zone                        = var.preferred_zone
  machine_type                = "db-custom-2-8192"
  deletion_protection_enabled = false
  retain_backups_on_delete    = false
  storage_size                = 10
  storage_autoresize          = true
  query_insights_enabled      = true
  storage_size_maximum        = 50
  authorized_networks = [
    {
      name    = "LesterIP"
      address = var.my_ip
    }
  ]
}

module "vaultwarden_db" {
  source            = "guerzon/gcp/modules//database"
  version           = "1.0.0"
  sql_instance_name = module.postgres.sql_instance_name
  database_name     = var.vaultwarden_database_name
  database_user     = var.vaultwarden_database_user
  database_password = var.vaultwarden_database_password
}