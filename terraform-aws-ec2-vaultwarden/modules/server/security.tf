resource "aws_security_group" "ec2_security_group" {
  name        = "vaultwarden-${var.environment}-sg"
  description = "Allow SSH and HTTPs traffic to the server"
  vpc_id      = var.vpc_id
  tags = {
    Name = "vaultwarden-${var.environment}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp" {
  security_group_id = aws_security_group.ec2_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ec2_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.ec2_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ec2_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "this" {
    security_group_id = aws_security_group.ec2_security_group.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}