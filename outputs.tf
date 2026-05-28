output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = module.vpc.vpc_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.igw.igw_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.nat.nat_gateway_ids
}

output "security_group_ids" {
  description = "List of security group IDs"
  value       = module.security_groups.security_group_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.alb_dns_name
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group"
  value       = module.autoscaling.autoscaling_group_name
}

output "ec2_instance_ids" {
  description = "List of EC2 instance IDs created by the EC2 module"
  value       = module.ec2_instances.instance_ids
}