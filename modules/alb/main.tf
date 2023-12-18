resource "aws_lb" "main" {
  name                       = "${var.name}-alb-${var.unique_id}"
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.sg_ids
  subnets                    = var.subnets
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  preserve_host_header       = var.preserve_host_header

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-alb-${var.unique_id}"
    }
  )
}

resource "aws_alb_target_group" "main" {
  name                 = "${var.name}-tg-${var.unique_id}"
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  ip_address_type      = var.ip_address_type
  deregistration_delay = var.deregistration_delay

  health_check {
    enabled             = var.health_check_enabled
    healthy_threshold   = var.health_check_healthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-tg-${var.unique_id}"
    }
  )
}

# Redirect to https listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Redirect traffic to target group
resource "aws_alb_listener" "https_main" {
  load_balancer_arn = aws_lb.main.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_tls_cert_arn

  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
  depends_on = [aws_alb_target_group.main]
}

resource "aws_route53_record" "main" {
  count      = var.app_domain != null && var.route53_hosted_zone_id != null ? 1 : 0
  zone_id    = var.route53_hosted_zone_id
  name       = var.app_domain
  type       = "CNAME"
  ttl        = 300
  records    = [aws_lb.main.dns_name]
  depends_on = [aws_lb.main]
}


