resource "aws_security_group" "this" {
  name        = "vaultwarden-${var.environment}-dbsecuritygroup"
  description = "Security Group for the database"
  vpc_id      = var.vpc_id
  tags = {
    Name = "vaultwarden-${var.environment}-dbsecuritygroup"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = var.database_port
  to_port           = var.database_port
  ip_protocol       = "tcp"
}
