resource "aws_db_subnet_group" "this" {
  name       = "vaultwarden-${var.environment}-dbsubnetgroup"
  subnet_ids = var.database_subnets
  tags = {
    Name = "vaultwarden-${var.environment}-dbsubnetgroup"
  }
}

resource "aws_db_instance" "this" {
  identifier                 = "vaultwarden-${var.environment}-postgres"
  engine                     = var.database_type
  engine_version             = var.database_version
  auto_minor_version_upgrade = var.minor_auto_upgrade
  allocated_storage          = var.storage.initial
  max_allocated_storage      = var.storage.maximum
  storage_type               = "io1"
  iops                       = 5000
  instance_class             = var.instance_class
  apply_immediately          = var.apply_immediately

  username = var.master_user.username
  password = var.master_user.password

  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = true
  copy_tags_to_snapshot   = false

  port                = var.database_port
  db_name             = var.database_name
  multi_az            = var.multi_az
  publicly_accessible = var.public_access

  performance_insights_enabled    = false
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "vaultwarden-${var.environment}-postgres"
  }

  depends_on = [aws_db_subnet_group.this]
}
