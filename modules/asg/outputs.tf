output "asg_name" {
  value = aws_autoscaling_group.main.name
}

output "sg_id" {
  value = aws_security_group.main.id
}