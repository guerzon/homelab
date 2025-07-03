variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}

variable "network_name" {
  description = "The name of the network to which the firewall rules will be applied."
  type        = string
}

variable "target_tags" {
  type        = list(string)
  description = "List of server tags to apply the firewall rules on"
}