output "ssl_certificate" {
  description = "Self-link to the classic SSL certificate"
  value       = google_compute_ssl_certificate.default.self_link
}