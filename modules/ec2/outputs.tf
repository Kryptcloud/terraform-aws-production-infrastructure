output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.app[count.index].id
}

output "private_ip_addresses" {
  description = "Private IP addresses of the created EC2 instances"
  value       = aws_instance.app[count.index].private_ip
}
