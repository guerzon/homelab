variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}

variable "ssl_certificate_name" {
  type        = string
  description = "Name of the SSL certificate"
  default     = null
}

variable "ssl_certificate_file" {
  type        = string
  description = "The file containing the PEM-format SSL certificate"
}

variable "ssl_private_key_file" {
  type        = string
  description = "The file containing the SSL private key"
}