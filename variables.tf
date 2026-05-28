# variable "region" {
#   type        = string
#   description = "AWS region for resource deployment"
# }

# variable "vpc_id" {
#   type        = string
#   description = "The ID of the VPC where the Auto Scaling group will be deployed"
# }

# variable "environment" {
#   type        = string
#   default     = "dev"
#   description = "Deployment environment name"
# }

# variable "internet_gateway_id" {
#   type        = string
#   description = "The ID of the Internet Gateway passed from the igw module"
# }

# variable "nat_gateway_ids" {
#   type        = list(string)
#   description = "The list of NAT Gateway IDs passed from the nat module"

# }

# variable "public_subnet_ids" {
#   type        = list(string)
#   description = "List of public subnet IDs"
# }

# variable "private_subnet_ids" {
#   type        = list(string)
#   description = "List of private subnet IDs"
# }


# variable "security_group_ids" {
#   type        = list(string)
#   description = "List of security group IDs passed from the security_groups module"
# }

# variable "autoscaling_group_name" {
#   type        = string
#   default     = "app-asg"
#   description = "Name of the Auto Scaling group"
# }

# variable "launch_configuration_name" {
#   type        = string
#   default     = "app-launch-configuration"
#   description = "Name of the launch configuration for the Auto Scaling group"
# }

# variable "ec2_instance_type" {
#   type        = string
#   default     = "t3.micro"
#   description = "EC2 instance type for the Auto Scaling group"
# }


# variable "vpc_cidr" {
#   type        = string
#   description = "CIDR block for the VPC"
# }

# variable "vpc_name" {
#   type        = string
#   description = "Name of the VPC"
# }




variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type for the Auto Scaling group"
}

variable "autoscaling_group_name" {
  type        = string
  default     = "app-asg"
  description = "Name of the Auto Scaling group"
}

variable "launch_configuration_name" {
  type        = string
  default     = "app-launch-configuration"
  description = "Name of the launch configuration for the Auto Scaling group"
}