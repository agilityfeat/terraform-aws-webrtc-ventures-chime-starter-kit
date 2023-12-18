output "application_domain" {
  description = "The domain name mapped to `lb_dns_value`. Output if a Route53 hosted zone was used, if not it will contain null."
  value       = module.alb.domain
}

output "lb_dns_value" {
  description = "The loadbalancer DNS name created by ElasticLoadbalancer. Since we are using https, this must be mapped to the corresponding domain/sudomain."
  value       = module.alb.dns_name
}
