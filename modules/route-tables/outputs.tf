output "public_route_table_ids" {
  description = "List of IDs for the public route tables"
  value       = aws_route_table.public[*].id
}

output "private_route_table_ids" {
  description = "List of IDs for the private route tables"
  value       = aws_route_table.private[*].id
}