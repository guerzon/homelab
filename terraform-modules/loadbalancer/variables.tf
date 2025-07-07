variable "environment" {
  type        = string
  description = "Environment for which the compute engine instance is being created (e.g., non-production, production)"
  validation {
    condition     = can(regex("^(non-production|production)$", var.environment))
    error_message = "Environment must be either 'non-production' or 'production'."
  }
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network where the compute engine instance will be created"
}

variable "instancegroups" {
  type = map(object({
    main   = string
    backup = string
  }))
  description = "Instance group for the load balancer"
}

variable "server_tags" {
  type        = list(string)
  description = "List of tags applied on the servers"
}

variable "backend_port_name" {
  type        = string
  description = "Port name of the backend API application"
}

variable "backend_port" {
  type        = number
  description = "Port number of the backend API application"
}

variable "frontend_port_name" {
  type        = string
  description = "Port name of the NodeJS frontend application"
}

variable "frontend_port" {
  type        = number
  description = "Port number of the NodeJS frontend application"
}

variable "base_url" {
  type        = string
  description = "API URL for the load balancer"
}

variable "api_url" {
  type        = string
  description = "API URL for the load balancer"
}

variable "build_backup" {
  type        = bool
  description = "Flag to indicate whether a backup instance is available and should be added to the ALB."
  default     = false
}

variable "proxyonly_subnets" {
  type = map(object({
    name       = string
    region     = string
    cidr_range = string
  }))
  description = "Name, region, and CIDR range of the main proxyonly subnetwork to be created. The key should be main or backup. When adding the backup subnet, make sure the flag build_backup is set to true."
  validation {
    condition = alltrue([
      for k in keys(var.proxyonly_subnets) : contains(["main", "backup"], k)
    ])
    error_message = "The key of the subnets map must be either 'main' or 'backup'."
  }
}

variable "security_policy_id" {
  type        = string
  description = "The ID of the Cloud Armor security policy to be applied to the load balancer"
}

variable "ssl_policy_profile" {
  type        = string
  description = "The SSL policy profile"
  default     = "RESTRICTED"
}

variable "ssl_min_tls_version" {
  type        = string
  description = "Minimum TLS version (e.g. TLS_1_2)"
  default     = "TLS_1_2"
}

variable "ssl_certificates" {
  type        = list(string)
  description = "List of one or more SSL certificate self-links to use for the HTTPs Load Balancer"
  default     = null
}