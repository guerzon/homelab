resource "google_compute_firewall" "health-checks" {
  name        = "fw-allow-health-checks"
  description = "Allow health checks from Global external ALB probe ranges"
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["8081", "3000"]
  }
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "iap" {
  name        = "fw-allow-ingress-from-iap"
  description = "Allow SSH access via IAP"
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "uptime-checks" {
  name        = "fw-allow-uptime-checks"
  description = "Allow uptime checks on servers"
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["8081", "3000"]
  }
  source_ranges = ["35.199.192.0/19"]
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "allow-icmp" {
  name        = "${var.environment}-allow-icmp"
  description = "Allows ICMP connections from any source"
  network     = var.network_name

  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.target_tags
  priority      = 65534
  disabled      = true
}

resource "google_compute_firewall" "allow-ssh" {
  name        = "${var.environment}-allow-ssh"
  description = "Allows TCP connections from any source to any instance on the network using port 22."
  network     = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.target_tags
  priority      = 65534
}
