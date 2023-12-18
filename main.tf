################################################
## VPC Module
################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name                               = "${var.name}-${var.vpc_name}"
  cidr                               = var.vpc_cidr
  azs                                = local.availability_zones
  public_subnets                     = var.vpc_public_subnets
  private_subnets                    = var.vpc_private_subnets
  create_database_subnet_group       = false
  create_database_subnet_route_table = false
  enable_nat_gateway                 = true
  single_nat_gateway                 = true # set this to false for high availability
  enable_dns_hostnames               = true
  enable_dns_support                 = true
  enable_dhcp_options                = true
  vpc_tags = merge(
    {
      Name = "${var.name}-${var.vpc_name}"
    },
    local.tags
  )
}

################################################
## AWS Certificate Mananger
################################################
# Optional module if you are using Route53
# To use this you must have a route53 hosted zone in the current AWS account
module "acm" {
  count                       = var.use_route53_hostedzone_for_acm == true ? 1 : 0
  source                      = "./modules/acm"

  app_domain                  = var.app_domain
  name                        = var.name
  route53_hosted_private_zone = var.route53_hosted.is_private
  route53_hosted_zone_id      = var.route53_hosted.zone_id
  subject_alternative_names   = []
  tags                        = local.tags
  depends_on                  = [module.vpc]
}

################################################
## Application LoadBalancer
################################################
module "alb_security_grp" {
  source        = "./modules/security-group"

  name          = var.name
  unique_id     = var.alb_unique_id
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.alb_sec_grp_ingress
  egress_rules  = var.alb_sec_grp_egress
  tags          = local.tags
}
module "alb" {
  source                           = "./modules/alb"
  name                             = var.name
  unique_id                        = var.alb_unique_id
  vpc_id                           = module.vpc.vpc_id
  sg_ids                           = [module.alb_security_grp.id]
  alb_tls_cert_arn                 = local.alb_tls_cert_arn
  app_domain                       = var.app_domain
  aws_account_id                   = var.aws_account_id
  aws_elb_account_id               = var.aws_elb_account_id
  aws_region                       = var.aws_region
  health_check_path                = var.alb_health_check_path
  route53_hosted_zone_id           = local.route53_hosted_zone_id
  subnets                          = module.vpc.public_subnets
  deregistration_delay             = var.alb_deregistration_delay
  enable_deletion_protection       = var.alb_enable_deletion_protection
  health_check_enabled             = var.alb_health_check_enabled
  health_check_healthy_threshold   = var.alb_health_check_healthy_threshold
  health_check_interval            = var.alb_health_check_interval
  health_check_matcher             = var.alb_health_check_matcher
  health_check_port                = var.alb_health_check_port
  health_check_protocol            = var.alb_health_check_protocol
  health_check_timeout             = var.alb_health_check_timeout
  health_check_unhealthy_threshold = var.alb_health_check_unhealthy_threshold
  idle_timeout                     = var.alb_idle_timeout
  internal                         = var.alb_internal
  ip_address_type                  = var.alb_ip_address_type
  load_balancer_type               = var.alb_load_balancer_type
  port                             = var.alb_port
  preserve_host_header             = var.alb_preserve_host_header
  target_type                      = var.alb_target_type

  depends_on = [module.acm]
}


################################################
## AutoScalingGroup Resources
################################################
module "asg_security_grp" {
  source        = "./modules/security-grp"
  name          = var.name
  unique_id     = var.asg_unique_id
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.asg_sec_grp_ingress
  egress_rules  = var.asg_sec_grp_egress
  tags          = local.tags
}

module "asg" {
  source                    = "./modules/asg"
  name                      = var.name
  unique_id                 = var.asg_unique_id
  sg_ids                    = [module.asg_security_grp.id]
  ami_id                    = var.asg_ami_id
  delete_on_termination     = var.asg_delete_on_termination
  detailed_monitoring       = var.asg_detailed_monitoring
  disk_size                 = var.asg_disk_size
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  instance_type             = var.asg_instance_type
  root_device               = var.asg_root_device
  size                      = var.asg_size_configuration
  subnet_ids                = module.vpc.private_subnets
  target_group_arns         = [module.alb.target_group_arn]
  vpc_id                    = module.vpc.vpc_id
  scaling_alarms_config     = var.asg_scaling_alarms_config
  scaling_policy            = var.asg_scaling_policy

  depends_on = [module.alb]
}
