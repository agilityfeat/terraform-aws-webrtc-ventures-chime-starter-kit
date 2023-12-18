output "application_domain" {
  value = module.alb.domain
}

output "lb_dns_value" {
  value = module.alb.dns_name
}
