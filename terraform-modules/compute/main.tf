resource "google_service_account" "default" {
  account_id   = var.compute_engine_sa_name
  display_name = "Custom service account for compute engine instances"
}

resource "google_compute_instance" "main" {
  name         = var.server_name
  machine_type = var.instance_type
  zone         = var.zone_main
  network_interface {
    subnetwork = var.subnetwork_main
    access_config {
      nat_ip = var.ip_main
    }
  }
  boot_disk {
    initialize_params {
      image = var.vm_instance_image
    }
    auto_delete = var.vm_auto_delete
  }
  key_revocation_action_type = "NONE"
  metadata                   = var.vm_metadata
  service_account {
    email  = google_service_account.default.email
    scopes = var.compute_engine_sa_scopes
  }
  metadata_startup_script = var.metadata_startup_script_main
  tags                    = var.tags
}

resource "google_compute_instance" "backup" {
  count        = var.build_backup ? 1 : 0
  name         = "${var.server_name}-backup"
  machine_type = var.instance_type
  zone         = var.zone_backup
  network_interface {
    subnetwork = var.subnetwork_backup
    access_config {
      nat_ip = var.ip_backup
    }
  }
  boot_disk {
    initialize_params {
      image = var.vm_instance_image
    }
    auto_delete = false
  }
  key_revocation_action_type = "NONE"
  metadata                   = var.vm_metadata
  service_account {
    email  = google_service_account.default.email
    scopes = var.compute_engine_sa_scopes
  }
  metadata_startup_script = var.metadata_startup_script_backup
  tags                    = var.tags
}