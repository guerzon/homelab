
resource "google_compute_instance_group" "default" {
  name = "${var.environment}-instance-group"
  zone = var.zone_main
  named_port {
    name = var.backend_port_name
    port = var.backend_port
  }
  named_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }
}

resource "google_compute_instance_group" "backup" {
  count = var.build_backup ? 1 : 0
  name  = "${var.environment}-instance-group-backup"
  zone  = var.zone_backup
  named_port {
    name = var.backend_port_name
    port = var.backend_port
  }
  named_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }
}

resource "google_compute_instance_group_membership" "default" {
  zone           = var.zone_main
  instance       = google_compute_instance.main.self_link
  instance_group = google_compute_instance_group.default.name
}

resource "google_compute_instance_group_membership" "backend" {
  count          = var.build_backup ? 1 : 0
  zone           = var.zone_backup
  instance       = google_compute_instance.backup[0].self_link
  instance_group = google_compute_instance_group.backup[0].name
}