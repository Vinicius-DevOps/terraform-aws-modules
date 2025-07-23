output "vpc_id" {
  description = "VPC ID created."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs."
  value       = aws_subnet.private[*].id
}

output "default_security_group_id" {
  description = "Default security group ID."
  value       = aws_vpc.main.default_security_group_id
}