variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the Auto Scaling group"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs to attach to the Auto Scaling group instances"
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
  description = "Optional ALB target group ARNs to register with the Auto Scaling group"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type for Auto Scaling instances"
}

variable "autoscaling_group_name" {
  type        = string
  default     = "app-asg"
  description = "Name of the Auto Scaling group"
}

variable "launch_configuration_name" {
  type        = string
  default     = "app-launch-configuration"
  description = "Name prefix for the launch configuration"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment name"
}

variable "min_size" {
  type        = number
  default     = 4
  description = "Minimum number of instances in the Auto Scaling group"
}

variable "max_size" {
  type        = number
  default     = 4
  description = "Maximum number of instances in the Auto Scaling group"
}

variable "desired_capacity" {
  type        = number
  default     = 4
  description = "Desired number of instances in the Auto Scaling group"
}
