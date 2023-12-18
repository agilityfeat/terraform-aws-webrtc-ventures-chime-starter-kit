output "asg_name" {
  description = "Autoscaling group name"
  value = aws_autoscaling_group.main.name
}