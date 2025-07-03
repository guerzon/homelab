resource "google_compute_network" "default" {
  name                    = "${var.environment}-vpc"
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "main_subnet" {
  name          = var.subnets.main.name
  network       = google_compute_network.default.id
  region        = var.subnets.main.region
  ip_cidr_range = var.subnets.main.cidr_range
}

resource "google_compute_subnetwork" "backup_subnet" {
  count         = var.build_backup ? 1 : 0
  name          = var.subnets.backup.name
  network       = google_compute_network.default.id
  region        = var.subnets.backup.region
  ip_cidr_range = var.subnets.backup.cidr_range
}

resource "google_compute_address" "default" {
  name         = "${var.environment}-vm-ip"
  description  = "For application deployment"
  address_type = "EXTERNAL"
  region       = var.subnets.main.region
}

resource "google_compute_address" "backup" {
  count        = var.build_backup ? 1 : 0
  name         = "${var.environment}-vm-ip-backup"
  description  = "For application deployment"
  address_type = "EXTERNAL"
  region       = var.subnets.backup.region
}
