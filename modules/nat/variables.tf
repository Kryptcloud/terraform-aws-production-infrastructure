variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs used to create NAT gateways"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name used for tags"
}

