output "network_name" {
  value       = google_compute_network.default.name
  description = "The name of the VPC network"
}

output "subnetwork_main" {
  value       = google_compute_subnetwork.main_subnet.self_link
  description = "The name of the created main subnetwork"
}

output "subnetwork_backup" {
  value       = var.build_backup ? google_compute_subnetwork.backup_subnet[0].self_link : null
  description = "The name of the created backup subnetwork"
}

output "static_ip_main" {
  value       = google_compute_address.default.address
  description = "The static IP address for the main static ip"
}

output "static_ip_backup" {
  value       = var.build_backup ? google_compute_address.backup[0].address : null
  description = "The static IP address for the backup static ip"
}

output "network" {
  value       = google_compute_network.default.self_link
  description = "The full self link of the created network"
}