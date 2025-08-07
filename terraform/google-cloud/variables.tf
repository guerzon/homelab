variable "environment" {
  default = "non-production"
}

variable "region" {
  default = "asia-southeast1"
}

variable "preferred_zone" {
  default = "asia-southeast1-a"
}

variable "router_name" {
  default = "homelab-router"
}

variable "my_ip" {
  description = "My network's external IP address."
}

variable "project_id" {}

variable "vaultwarden_database_name" {
  default = null
}

variable "vaultwarden_database_user" {
  default = null
}

variable "vaultwarden_database_password" {
  default = null
}

variable "public_zone_dns" {
  default = null
}

variable "private_zone_dns" {
  default = null
}