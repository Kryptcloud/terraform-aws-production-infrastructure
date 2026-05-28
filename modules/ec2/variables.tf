variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the EC2 instances"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to the EC2 instances"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "instance_count" {
  type        = number
  default     = 4
  description = "Number of EC2 instances to create"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name"
}
