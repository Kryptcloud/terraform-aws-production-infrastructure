
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "internet_gateway_id" {
  type        = string
  description = "The ID of the Internet Gateway passed from the igw module"
}

variable "nat_gateway_ids" {
  type        = list(string)
  description = "The list of NAT Gateway IDs passed from the nat module"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}
