
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ec2_instance" {
  description = "EC2 Instance type"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the volume"
  type        = string
}
