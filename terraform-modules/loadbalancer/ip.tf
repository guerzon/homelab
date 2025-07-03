resource "google_compute_global_address" "loadbalancer" {
  name         = "${var.environment}-external-lb-ip"
  address_type = "EXTERNAL"
}