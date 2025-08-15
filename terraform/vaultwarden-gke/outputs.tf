output "sql_private_ip" {
  description = "The private IP address of the PostgreSQL instance."
  value       = module.postgres.internal_ip
}