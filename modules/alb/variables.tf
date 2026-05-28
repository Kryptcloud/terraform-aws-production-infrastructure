variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Application Load Balancer is deployed"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for the Application Load Balancer"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to the Application Load Balancer"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name"
}
