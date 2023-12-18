locals {
  env                = terraform.workspace
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]

  alb_tls_cert_arn       = var.use_route53_hostedzone_for_acm == true ? module.acm[0].arn : var.acm_cert_arn
  route53_hosted_zone_id = var.use_route53_hostedzone_for_acm == true ? var.route53_hosted.zone_id : null

  tags = {
    Environment = local.env
    Project     = var.name
  }
}
