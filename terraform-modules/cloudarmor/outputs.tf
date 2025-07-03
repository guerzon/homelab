output "cloud_armor_policy_id" {
  description = "The ID of the Cloud Armor policy"
  value       = google_compute_security_policy.default.id
}