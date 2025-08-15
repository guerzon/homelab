variable "project_id" {
  type = string
}

variable "environment" {
  default = "homelab"
  type    = string
}

variable "region" {
  default = "asia-southeast1"
  type    = string
}

variable "public_zone_dns" {
  type = string
}