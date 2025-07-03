output "database_conn" {
  description = "The connection name of the Cloud SQL instance."
  value       = google_sql_database_instance.default.ip_address[0].ip_address
}