resource "google_compute_ssl_certificate" "default" {
  name        = "${var.environment}-le-cert"
  description = "Let's Encrypt SSL certificate"
  private_key = file(var.ssl_private_key)
  certificate = file(var.ssl_certificate)
}

resource "google_compute_ssl_policy" "default" {
  name            = "${var.environment}-ssl-policy"
  profile         = var.ssl_policy_profile
  min_tls_version = var.ssl_min_tls_version
  description     = "SSL policy for ${var.environment} environment"
}