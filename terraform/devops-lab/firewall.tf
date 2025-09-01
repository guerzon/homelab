resource "google_compute_firewall" "allow_apps" {
  name    = "${var.environment}-allow-apps-devops-lab"
  network = data.terraform_remote_state.common_gcp.outputs.vpc_network
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "5432"]
  }
  source_ranges = [
    var.my_ip,
    module.node1.public_ip # allow connections coming from Azure agent
  ]
  priority    = 65534
  target_tags = ["nginx", "postgres"]
}

resource "google_compute_firewall" "allow_monitoring" {
  name    = "${var.environment}-allow-monitoring"
  network = data.terraform_remote_state.common_gcp.outputs.vpc_network
  allow {
    protocol = "tcp"
    ports = [
      "9090", # prometheus
      "9100"  # node_exporter
    ]
  }
  source_ranges = [
    var.my_ip,             # allow access from my IP
    module.node1.public_ip # allow scraping from prometheus server
  ]
  priority    = 65534
  target_tags = ["prometheus-clients"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.environment}-allow-ssh"
  network = data.terraform_remote_state.common_gcp.outputs.vpc_network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.my_ip]
  priority      = 65534
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "allow_iap" {
  name    = "${var.environment}-allow-iap"
  network = data.terraform_remote_state.common_gcp.outputs.vpc_network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  priority      = 65534
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.environment}-allow-icmp"
  network = data.terraform_remote_state.common_gcp.outputs.vpc_network
  allow {
    protocol = "icmp"
  }
  source_ranges = [var.my_ip]
  priority      = 65534
  target_tags   = ["icmp"]
}