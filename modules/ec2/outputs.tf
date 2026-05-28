output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.app[*].id
}

output "private_ip_addresses" {
  description = "Private IP addresses of the created EC2 instances"
  value       = aws_instance.app[*].private_ip
}
