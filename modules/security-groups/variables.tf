variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security groups will be created"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name used for tags"
}

variable "allowed_ssh_cidr" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR block(s) allowed to connect via SSH"
}
