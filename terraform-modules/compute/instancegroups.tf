resource "google_compute_instance_group" "default" {
  name = "${var.environment}-instance-group"
  zone = var.zone
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
  zone           = var.zone
  instance       = google_compute_instance.default.self_link
  instance_group = google_compute_instance_group.default.name
}