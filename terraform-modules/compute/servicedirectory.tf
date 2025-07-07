// This is for the monitoring of the main server (ONLY)

data "google_project" "project" {
  provider = google-beta
}

resource "google_service_directory_namespace" "default" {
  provider     = google-beta
  namespace_id = "${var.environment}-namespace"
  location     = var.region
}

resource "google_service_directory_service" "default" {
  provider   = google-beta
  service_id = "${var.environment}-service"
  namespace  = google_service_directory_namespace.default.id
}

resource "google_service_directory_endpoint" "backend_endpoint" {
  provider    = google-beta
  endpoint_id = "${var.environment}-backend-endpoint"
  service     = google_service_directory_service.default.id
  network     = "projects/${data.google_project.project.number}/locations/global/networks/${var.network_name}"

  address = google_compute_instance.default.network_interface[0].network_ip
  port    = 8081
}

resource "google_service_directory_endpoint" "frontend_endpoint" {
  provider    = google-beta
  endpoint_id = "${var.environment}-frontend-endpoint"
  service     = google_service_directory_service.default.id
  network     = "projects/${data.google_project.project.number}/locations/global/networks/${var.network_name}"

  address = google_compute_instance.default.network_interface[0].network_ip
  port    = 3031
}