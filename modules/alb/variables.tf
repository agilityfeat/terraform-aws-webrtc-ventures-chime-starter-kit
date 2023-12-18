variable "app_domain" {
  type        = string
  description = "The effective ALB domain name, used to create a CNAME record"
}
variable "sg_ids" {
  type        = list(string)
  description = "A list of security group IDs."
}
variable "alb_tls_cert_arn" {
  type        = string
  description = "The ARN of the certificate that the ALB uses for https"
}
variable "aws_account_id" {
  type        = string
  description = "Current AWS account id"
}
variable "aws_elb_account_id" {
  type        = string
  description = "Current ELB account id, varies per AWS region"
}
variable "aws_region" {
  type        = string
  description = "Current AWS region"
}
variable "deregistration_delay" {
  type        = number
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  default     = 300
}
variable "unique_id" {
  type        = string
  description = "Unique identifier to be appended on resource names."
}
variable "health_check_enabled" {
  type        = bool
  description = "Whether healthchecking is enabled"
  default     = true
}
variable "health_check_interval" {
  type        = number
  description = "Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300."
  default     = 70
}
variable "health_check_healthy_threshold" {
  type        = number
  description = "Number of consecutive health check successes required before considering a target healthy. The range is 2-10."
  default     = 2
}
variable "health_check_matcher" {
  type        = string
  description = "Response codes to use when checking for a healthy responses from a target"
  default     = "200,201,300,301"
}
variable "health_check_path" {
  type        = string
  description = "Destination for the health check request"
}
variable "health_check_port" {
  type        = string
  description = "The port the load balancer uses when performing health checks on targets"
  default     = "80"
}
variable "health_check_protocol" {
  type        = string
  description = "Protocol the load balancer uses when performing health checks on targets."
  default     = "HTTP"
}
variable "health_check_timeout" {
  type        = string
  description = "Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds."
  default     = "60"
}
variable "health_check_unhealthy_threshold" {
  type        = string
  description = "Number of consecutive health check failures required before considering a target unhealthy."
  default     = "5"
}
variable "idle_timeout" {
  type        = number
  description = "Idle timeout for the LoadBalancer [0 - 4000] seconds"
  default     = 60
}
variable "internal" {
  type        = bool
  description = "Whether to create a private LoadBalancer."
  default     = false
}
variable "enable_deletion_protection" {
  type        = bool
  description = "Whether to protect the LoadBalancer from deletion."
  default     = false
}
variable "preserve_host_header" {
  type        = bool
  description = "Whether to preserve host header on the incoming requests."
  default     = true
}
variable "ip_address_type" {
  type        = string
  description = "The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6"
  default     = "ipv4"
}
variable "name" {
  type        = string
  description = "Project name"
}
variable "load_balancer_type" {
  type        = string
  description = "Type of the Elastic Loadbalancer"
  default     = "application"
}
variable "protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP"
  default     = "HTTP"
}
variable "port" {
  type        = number
  description = "Port on which targets receive traffic, unless overridden when registering a specific target."
  default     = 80
}
variable "route53_hosted_zone_id" {
  type        = string
  description = "Route53 hosted zone id"
  default     = null
}
variable "subnets" {
  description = "Comma separated list of subnet IDs"
}
variable "target_type" {
  type        = string
  description = "Type of target that you must specify when registering targets with this target group. https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html"
  default     = "instance"
}
variable "vpc_id" {
  type        = string
  description = "ID of the current VPC"
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}




