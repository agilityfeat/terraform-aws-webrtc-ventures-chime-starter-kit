locals {
  /* domain_prod = var.aws_region == "us-west-2" ? "${var.domain_prefix}.us2.${var.route53_hosted_zone_name}" : "${var.domain_prefix}.${var.route53_hosted_zone_name}"
  domain_dev  = "${var.domain_prefix}.${var.environment}.${var.route53_hosted_zone_name}"

  # domain_name = var.environment == "prod" ? "${var.domain_prefix}.${var.route53_hosted_zone_name}" : "${var.domain_prefix}.${var.environment}.${var.route53_hosted_zone_name}"
  domain_name = var.environment == "prod" ? local.domain_prod : local.domain_dev */

  /* redirection_dvos = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
    if strcontains(dvo.resource_record_value, var.route53_domain_substr.main) == true
  }
  main_dvos = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
    if strcontains(dvo.resource_record_value, var.route53_domain_substr.main) == true
  } */
}
