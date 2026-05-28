output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group"
  value       = aws_autoscaling_group.asg.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling group"
  value       = aws_autoscaling_group.asg.arn
}

# output "instance_ids" {
#   description = "IDs of instances managed by the Auto Scaling group"
#   value       = aws_autoscaling_group.asg.instances[*].id
# }
