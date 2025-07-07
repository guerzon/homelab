output "instance_group" {
  value       = google_compute_instance_group.default.self_link
  description = "Instance group for the main backend and frontend services"
}