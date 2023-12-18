output "target_group_arn" {
  value = aws_alb_target_group.main.arn
}
output "target_group_name" {
  value = aws_alb_target_group.main.name
}
output "domain" {
  value = try(var.app_domain, "")
}
output "dns_name" {
  value = aws_lb.main.dns_name
}
