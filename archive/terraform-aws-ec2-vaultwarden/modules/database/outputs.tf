output "database_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "FQDN for the RDS instance"
}
