variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}

variable "subnets" {
  type = map(object({
    name       = string
    region     = string
    cidr_range = string
  }))
  description = "Name, region, and CIDR range of the main subnetwork to be created. The key should be main or backup. When adding the backup subnet, make sure the flag build_backup is set to true."
  validation {
    condition = alltrue([
      for k in keys(var.subnets) : contains(["main", "backup"], k)
    ])
    error_message = "The key of the subnets map must be either 'main' or 'backup'."
  }
}

variable "build_backup" {
  type        = bool
  description = "Flag to indicate whether to create a backup instance"
  default     = false
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "Auto-create subnets or not"
  default     = false
}

variable "routing_mode" {
  type        = string
  description = "Routing mode"
  default     = "REGIONAL"
}
