resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = 15
  type              = "gp3"
  tags = {
    Name = "vaultwarden-${var.environment}-data"
  }
}

resource "aws_volume_attachment" "data" {
  device_name = "/dev/sdx"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.this.id
}
