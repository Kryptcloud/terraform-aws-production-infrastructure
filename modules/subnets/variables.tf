variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where subnets will be created"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name used for tags"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
  description = "The availability zones to create subnets in"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "CIDR blocks for private subnets"
}