variable "project_id" {
  type = string
}

variable "environment" {
  default = "sreafterhours"
  type    = string
}

variable "domain_name" {
  type    = string
  default = "sreafterhours.dev."
}

variable "region" {
  type = string
}

variable "my_ip" {
  description = "My network's external IP address."
  type        = string
}

variable "instance_image" {
  type = string
}

variable "ssh_string" {
  description = "SSH string to be added to the instance. Example: 'username:ssh-rsa AAAAB3...'"
  type        = string
}

variable "tags" {
  type        = list(string)
  description = "List of tags to be applied to the compute engine instance"
  default     = []
}