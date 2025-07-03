resource "aws_eip" "this" {
  tags = {
    Name = "vaultwarden-${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "vaultwarden-${var.environment}-nat"
  }
  depends_on = [aws_internet_gateway.this]
}