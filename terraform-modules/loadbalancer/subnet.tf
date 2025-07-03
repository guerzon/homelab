// Proxy-only subnet

resource "google_compute_subnetwork" "main_proxyonly_subnet" {
  name          = var.proxyonly_subnets.main.name
  network       = var.network_name
  region        = var.proxyonly_subnets.main.region
  ip_cidr_range = var.proxyonly_subnets.main.cidr_range
  purpose       = "GLOBAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_subnetwork" "backup_proxyonly_subnet" {
  count         = var.build_backup ? 1 : 0
  name          = var.proxyonly_subnets.backup.name
  network       = var.network_name
  region        = var.proxyonly_subnets.backup.region
  ip_cidr_range = var.proxyonly_subnets.backup.cidr_range
  purpose       = "GLOBAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_firewall" "main_proxy_only_subnet" {
  name        = "fw-allow-main-proxyonly-subnet"
  description = "Allow connection from the main proxy-only subnet used by the external ALB"
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["${var.backend_port}", "${var.frontend_port}"]
  }
  source_ranges = [google_compute_subnetwork.main_proxyonly_subnet.ip_cidr_range]
  target_tags   = var.server_tags
}