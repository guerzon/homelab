variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}