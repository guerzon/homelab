resource "google_compute_ssl_certificate" "default" {
  name        = var.ssl_certificate_name != null ? var.ssl_certificate_name : "${var.environment}-le-cert"
  description = "Let's Encrypt SSL certificate"
  private_key = file(var.ssl_private_key_file)
  certificate = file(var.ssl_certificate_file)
}
