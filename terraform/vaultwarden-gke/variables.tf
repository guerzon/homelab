variable "region" {
  default = "asia-southeast1"
  type    = string
}

variable "preferred_zone" {
  default = "asia-southeast1-a"
  type    = string
}

variable "my_ip" {
  description = "My network's external IP address."
  type        = string
}

variable "project_id" {
  type = string
}

variable "vaultwarden_database_name" {
  type = string
}

variable "vaultwarden_database_user" {
  type = string
}

variable "vaultwarden_database_password" {
  type = string
}

variable "public_zone_dns" {
  type = string
}