resource "google_compute_ssl_policy" "default" {
  name            = "${var.environment}-ssl-policy"
  profile         = var.ssl_policy_profile
  min_tls_version = var.ssl_min_tls_version
  description     = "SSL policy for ${var.environment} environment"
}