output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {
  description = "List of all created private subnets"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "List of all created public subnets"
  value       = aws_subnet.public[*].id
}

output "vpc_cidr" {
  description = "CIDR range of the VPC"
  value       = aws_vpc.this.cidr_block
}
