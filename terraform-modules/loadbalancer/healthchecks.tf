resource "google_compute_health_check" "backend" {
  name = "healthcheck-backend"
  tcp_health_check {
    port = var.backend_port
  }
}

resource "google_compute_health_check" "frontend" {
  name = "healthcheck-frontend"
  tcp_health_check {
    port = var.frontend_port
  }
}