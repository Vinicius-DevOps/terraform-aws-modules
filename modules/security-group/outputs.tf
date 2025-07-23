# Saídas do módulo Security Group

output "security_group_id" {
  description = "O ID do Security Group criado."
  value       = aws_security_group.main.id
}

output "security_group_name" {
  description = "O nome do Security Group criado."
  value       = aws_security_group.main.name
}