# module "gke" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//kubernetes"
#   source               = "../../../Google-Cloud/terraform-modules-gcp/kubernetes"
#   cluster_name         = "homelab"
#   network              = module.vpc.network
#   subnet               = "singapore-subnet"
#   location             = var.preferred_zone # zonal cluster
#   node_pool_type       = "preemptible"
#   node_pool_count      = 2
#   enable_private_nodes = true
#   deletion_protection  = false
# }

# module "postgres" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//sqlinstance"
#   source                      = "../../../Google-Cloud/terraform-modules-gcp/sqlinstance"
#   instance_name               = "portfolio"
#   database_version            = "POSTGRES_17"
#   network_name                = module.vpc.network
#   availability_type           = "ZONAL"
#   region                      = "asia-southeast1"
#   zone                        = "asia-southeast1-c"
#   machine_type                = "db-custom-2-8192"
#   deletion_protection_enabled = false
#   retain_backups_on_delete    = false
#   storage_size                = 10
#   storage_autoresize          = true
#   query_insights_enabled      = true
#   storage_size_maximum        = 50
#   authorized_networks = [
#     {
#       name    = "LesterIP"
#       address = var.my_ip
#     }
#   ]
# }

# # Vaultwarden database
# module "vaultwarden_db" {
#   # source      = "git::https://github.com/guerzon/terraform-modules-gcp//database"
#   source            = "../../../Google-Cloud/terraform-modules-gcp/database"
#   sql_instance_name = module.postgres.sql_instance_name
#   database_name     = var.vaultwarden_database_name
#   database_user     = var.vaultwarden_database_user
#   database_password = var.vaultwarden_database_password
# }