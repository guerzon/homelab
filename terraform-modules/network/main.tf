resource "google_compute_network" "default" {
  name                    = "${var.environment}-vpc"
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "default" {
  name          = var.subnets.main.name
  network       = google_compute_network.default.id
  region        = var.subnets.main.region
  ip_cidr_range = var.subnets.main.cidr_range
}

resource "google_compute_address" "default" {
  name         = "${var.environment}-vm-ip"
  description  = "For application deployment"
  address_type = "EXTERNAL"
  region       = var.subnets.main.region
}