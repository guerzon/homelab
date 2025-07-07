output "network" {
  value       = google_compute_network.default.self_link
  description = "The full self link of the created network"
}

output "network_name" {
  value       = google_compute_network.default.name
  description = "The name of the VPC network"
}

output "subnetwork" {
  value       = google_compute_subnetwork.default.self_link
  description = "The name of the created main subnetwork"
}

output "static_ip" {
  value       = google_compute_address.default.address
  description = "The static IP address for the main static ip"
}