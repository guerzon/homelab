resource "google_compute_security_policy" "default" {
  name        = "${var.environment}-cloudarmor-policy"
  type        = "CLOUD_ARMOR"
  description = "Cloud Armor security policy for ${var.environment} environment"
}