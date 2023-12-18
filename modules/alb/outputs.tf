output "target_group_arn" {
  description = "LoadBalancer main target group arn"
  value       = aws_alb_target_group.main.arn
}
output "target_group_name" {
  description = "LoadBalancer main target group name"
  value       = aws_alb_target_group.main.name
}
output "domain" {
  description = "LoadBalancer mapped domain/subdomain. Depends on whether Rout53 was used or not."
  value       = try(var.app_domain, "")
}
output "dns_name" {
  description = "The LoadBalancer DNS name from created by ELB. Used to map the domain name for accessing the application."
  value       = aws_lb.main.dns_name
}
