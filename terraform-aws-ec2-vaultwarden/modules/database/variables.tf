
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
}

variable "database_type" {
  description = "Database type"
  type        = string
  validation {
    condition     = contains(["postgres"], var.database_type)
    error_message = "Invalid database type. Currently, only 'postgres' databases are supported."
  }
}

variable "database_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "database_version" {
  description = "Database engine version"
  type        = string
  default     = "16.5"
}

variable "storage" {
  description = "Specify storage settings for this database."
  type = object({
    initial = number
    maximum = number
  })
  validation {
    condition     = (var.storage.initial >= 100)
    error_message = "Initial storage size must be at least 100 GiB."
  }
  validation {
    condition     = (var.storage.initial <= var.storage.maximum)
    error_message = "Initial storage size should be less than maximum storage."
  }
}

variable "instance_class" {
  description = "Database instance class"
  default     = "db.r5.xlarge"
  type        = string
  validation {
    condition     = can(regex("^(db.)", var.instance_class))
    error_message = "Invalid instance class. Please only specify a valid instance class, or use the default db.r5.xlarge."
  }
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = false
}

variable "master_user" {
  description = "Master database user"
  type = object({
    username = string
    password = string
  })
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period (days)"
  default     = 14
}

variable "database_name" {
  description = "Database name"
  default     = "vaultwarden"
  type        = string
}

variable "database_subnets" {
  description = "Database subnets"
  type        = list(string)
}

variable "multi_az" {
  description = "Deploy the instance in multiple availability zones"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "minor_auto_upgrade" {
  description = "Auto upgrade minor versions"
  type        = bool
  default     = false
}

variable "public_access" {
  description = "If instance is publicly-accessible"
  type        = bool
  default     = false
}
