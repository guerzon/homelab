output "load_balancer_ip" {
  description = "The IP address of the external load balancer"
  value       = google_compute_global_address.loadbalancer.address
}