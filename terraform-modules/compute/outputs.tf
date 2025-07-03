output "instance_group_main" {
  value       = google_compute_instance_group.default.self_link
  description = "Instance group for the main backend and frontend services"
}

output "instance_group_backup" {
  value       = var.build_backup ? google_compute_instance_group.backup[0].self_link : null
  description = "Instance group for the backup backend and frontend services"
}