output "id" {
  description = "Security ID"
  value = aws_security_group.main.id
}

output "name" {
  description = "Security group name"
  value = aws_security_group.main.name
}
