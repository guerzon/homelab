resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  database_version = var.database_version
  settings {
    tier              = var.machine_type
    edition           = var.edition
    availability_type = var.availability_type
    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.network_name
      ssl_mode        = var.ssl_mode
      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        iterator = net
        content {
          name  = net.value.name
          value = net.value.address
        }
      }
      enable_private_path_for_google_cloud_services = var.enable_psa
    }
    location_preference {
      zone = var.zone
    }
    disk_size             = var.storage_size
    disk_autoresize       = var.storage_autoresize
    disk_autoresize_limit = var.storage_size_maximum
    backup_configuration {
      enabled            = var.backup_enabled
      binary_log_enabled = var.binary_log_enabled
      start_time         = var.backup_start_time
      location           = var.backup_location
    }
    maintenance_window {
      day          = 6
      hour         = 16
      update_track = "stable"
    }
    deletion_protection_enabled = var.deletion_protection_enabled
    retain_backups_on_delete    = var.retain_backups_on_delete
    insights_config {
      query_insights_enabled = var.query_insights_enabled
      query_string_length    = var.query_string_length
    }
  }
}