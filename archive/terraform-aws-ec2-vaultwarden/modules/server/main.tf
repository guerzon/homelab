data "aws_ami" "rhel9_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["RHEL-9.4*_HVM-*x86_64*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_key_pair" "this" {
  key_name   = "lester@rheldev"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUyfAetptrHNJdor+fqysCm7EhLTKyje9VbY8iOlN3jWrwbSdEtsnkIualaQHrcJkrs0W966ULDKF0HB9iTsUZykW2WiuWmCk3v0Ub2wuaf2DRKLoke09CE6fBTHuNvP0H+5Ed29oiUF4pDQd4nAXf3YF/hiJ/FvLP8NZFIelKhGCakPgtz+OkbReG/WYoVrcNwK5+UQWKti+KxG+ohQI9XkR1TZ3/8JtKKmrH0LxPvYmxm4Lq+ZXDgEJXlGpYk4+BxeXyXTzjmu1M/Q9L3y7rCgc89G9pUwZuyd5J4QFVh/OVfD+7uowyaLry1llhHkfMi4ubSSvYNdTbpTs27nE6rk/9BGcuiXPAMxQTXY6wYyCEjKP10t9V9RDRL2Uj95SC0So6UVYykcRxsoEEvzXcaVAj1V5H6T2DlmQ+mejo5vMy2vig5RQZ6iSfek9VQ6Iaa8lVOJrAvHHmgFAsomU5SBF16YkUEOVfvf9kTr5Cng1uZD80LB6aE4FLuKZ59Gs= lester@rheldev"
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  tags = {
    Name = "vaultwarden-${var.environment}-server-eip"
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.rhel9_ami.id
  instance_type = var.ec2_instance
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.this.key_name
  monitoring    = true
  vpc_security_group_ids = [ aws_security_group.ec2_security_group.id ]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    tags = {
      Name = "vaultwarden-${var.environment}-root"
    }
  }

  tags = {
    Name = "vaultwarden-${var.environment}-server"
  }
}
