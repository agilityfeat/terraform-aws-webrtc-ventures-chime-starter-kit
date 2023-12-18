variable "name" {
  type        = string
  description = "Project name"
  default     = "chimestarterkitex1"
}
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "aws_account_id" {
  type        = string
  description = "Current AWS account ID"
  # default     = "223EXAMPLEID14"
}
variable "aws_elb_account_id" {
  type        = string
  description = "Current AWS ELB Account ID obtain the ID for the region you are deploying into. Obtainable from https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html"
  default     = "127311923021" # this one is for us-east-1
}
#############################################
# VPC
#############################################
variable "vpc_cidr" {
  type        = string
  description = "Main VPC CIDR"
  default     = "173.18.0.0/16"
}
variable "vpc_name" {
  type        = string
  description = "Names assigned to the vpc"
  default     = "vpc"
}
variable "vpc_private_subnets" {
  type        = list(string)
  description = "VPC Private subnet CIDRs"
  default     = ["173.18.48.0/20", "173.18.64.0/20", "173.18.80.0/20"]
}
variable "vpc_public_subnets" {
  type        = list(string)
  description = "VPC Public subnet CIDRs"
  default     = ["173.18.96.0/20", "173.18.112.0/20", "173.18.128.0/20"]
}

#######################################
# ACM and DNS
#######################################
variable "acm_unique_id" {
  type        = string
  description = "Unique id to be appended on ACM resource names."
  default     = "acm-prod"
}
variable "use_route53_hostedzone_for_acm" {
  type        = bool
  description = "Indicates whether you are using a route53 hosted zone created in the current account you are using"
  default     = false
}
variable "route53_hosted" {
  type = object({
    zone_id    = string
    is_private = bool
  })
  description = "If using Route53, supply the Route53 zone details"
  default = {
    zone_id    = null
    is_private = null
  }
}

variable "app_domain" {
  type        = string
  description = "If using Route53 supply the domain on which the application will be accessed. It must be the same domain/subsdomain name used to generete the ACM certificate."
  # default     = "chimestarterkit.example.com"
}

variable "acm_cert_arn" {
  type        = string
  description = "TLS certificate ARN from the AWS Certicate Manager console"
  default     = null # "arn:aws:acm:REGION:EXAMPLE:certificate/EXAMPLE423b3-EXAMPLE-CERTIFICATE"
}

################################################
# Application LoadBalancer Variables
################################################
variable "alb_unique_id" {
  type        = string
  description = "The unique string to identify LoadBalancer module resources; appended on the resource names."
  default     = "alb-prod"
}
variable "alb_deregistration_delay" {
  type        = number
  description = "Amount time in seconds for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  default     = 300
}
variable "alb_enable_deletion_protection" {
  type        = bool
  description = "Whether to protect the LoadBalancer from deletion."
  default     = false
}
variable "alb_health_check_enabled" {
  type        = bool
  description = "Whether health checking is enabled"
  default     = true
}
variable "alb_health_check_interval" {
  type        = number
  description = "Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300."
  default     = 70
}
variable "alb_health_check_healthy_threshold" {
  type        = number
  description = "Number of consecutive health check successes required before considering a target healthy. The range is 2-10."
  default     = 2
}
variable "alb_health_check_matcher" {
  type        = string
  description = "Response codes to use when checking for a healthy responses from a target"
  default     = "200,201,300,301"
}
variable "alb_health_check_path" {
  type        = string
  description = "The healthcheck path to be queries by the LoadBalancer."
  default     = "/"
}
variable "alb_health_check_port" {
  type        = string
  description = "The port the load balancer uses when performing health checks on targets"
  default     = "80"
}
variable "alb_health_check_protocol" {
  type        = string
  description = "Protocol the load balancer uses when performing health checks on targets."
  default     = "HTTP"
}
variable "alb_health_check_timeout" {
  type        = string
  description = "Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds."
  default     = "60"
}
variable "alb_health_check_unhealthy_threshold" {
  type        = string
  description = "Number of consecutive health check failures required before considering a target unhealthy."
  default     = "5"
}
variable "alb_idle_timeout" {
  type        = number
  description = "Idle timeout for the LoadBalancer [0 - 4000] seconds"
  default     = 60
}
variable "alb_internal" {
  type        = bool
  description = "Whether to create a private LoadBalancer."
  default     = false
}
variable "alb_ip_address_type" {
  type        = string
  description = "The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6"
  default     = "ipv4"
}
variable "alb_load_balancer_type" {
  type        = string
  description = "Type of the Elastic Loadbalancer"
  default     = "application"
}
variable "alb_port" {
  type        = number
  description = "Port on which targets receive traffic, unless overridden when registering a specific target."
  default     = 80
}
variable "alb_preserve_host_header" {
  type        = bool
  description = "Whether to preserve host header on the incoming requests."
  default     = true
}
variable "alb_target_type" {
  type        = string
  description = "Type of target that you must specify when registering targets with this target group. https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html"
  default     = "instance"
}
variable "alb_sec_grp_ingress" {
  type = list(object({
    cidr_blocks      = list(string)
    description      = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    protocol         = string
    security_groups  = list(string)
    to_port          = number
    self             = bool
  }))
  description = "A list of ingress rule as objects for the ALB security group"
  default = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTP"
      from_port        = 80
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      to_port          = 80
      self             = null
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTPS"
      from_port        = 443
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      to_port          = 443
      self             = null
    }
  ]
}
variable "alb_sec_grp_egress" {
  type = list(object({
    cidr_blocks      = list(string)
    description      = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    protocol         = string
    security_groups  = list(string)
    to_port          = number
    self             = bool
  }))
  description = "A list of egress rule as objects for the ALB security group"
  default = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Everywhere"
      from_port        = 0
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "-1"
      security_groups  = null
      to_port          = 0
      self             = null
    }
  ]
}


################################################
# AutoScalingGroup Variables
################################################
variable "asg_unique_id" {
  type        = string
  description = "The unique string to identify ASG module resources; appended on the resource names."
  default     = "asg-prod"
}
variable "asg_ami_id" {
  type        = string
  description = "The AMI ID from the product configuration page on AWS Marketplace. You must first subscribe to the product and then click on configuration button to view the AMI details."
  # default     = "ami-0392f984eb68af012" # get the correct upto date ami ID from the AWS market place
}
variable "asg_delete_on_termination" {
  type        = bool
  description = "Delete ELB volume on instance termination"
  default     = true
}
variable "asg_detailed_monitoring" {
  type        = bool
  description = "Enable detailed monitoring of the instances in the ASG"
  default     = true
}
variable "asg_disk_size" {
  type        = number
  description = "The disk size allocated for each instance"
  default     = 40
}
variable "asg_health_check_grace_period" {
  type        = number
  description = "The disk size allocated for each instance"
  default     = 300
}
variable "asg_health_check_type" {
  type        = string
  description = "The healthcheck type used by ASG. Can be ELB or EC2"
  default     = "ELB"
}

variable "asg_instance_type" {
  type        = string
  description = "The instance type used by ASG on the launced instances"
  default     = "t2.small"
}
variable "asg_root_device" {
  type        = string
  description = "The root device for the instances. Default /dev/xvda for Amazon Linux instances used for this setup."
  default     = "/dev/xvda"
}
variable "asg_size_configuration" {
  type = object({
    max_size                 = number
    min_size                 = number
    warm_pool_pool_state     = string # ["Hibernated" "Stopped" "Running" "Hibernated"]
    warm_pool_prep_capacity  = number
    warm_pool_prep_min_size  = number
    warm_pool_reuse_on_scale = bool
  })
  description = "The configuration for the ASG size. The warmpool variable define the instances that will be prepared in adavance and their waiting states."
  default = {
    max_size                 = 2
    min_size                 = 1
    warm_pool_pool_state     = "Hibernated" # ["Stopped" "Running" "Hibernated"]
    warm_pool_prep_capacity  = 1
    warm_pool_prep_min_size  = 1
    warm_pool_reuse_on_scale = true
  }
}
variable "asg_scaling_alarms_config" {
  type = map(object({
    enabled            = bool
    threshold          = number
    evaluation_periods = number
    period             = number
  }))
  description = "A map of objects with values for the Autosacling group alarms configurations."
  default = {
    cpu_scale_in = {
      enabled            = true
      threshold          = 10
      evaluation_periods = 3
      period             = 120
    }
    cpu_scale_out = {
      enabled            = true
      threshold          = 75
      evaluation_periods = 2
      period             = 120
    }
    net_out_scale_in = {
      enabled            = false
      threshold          = null #120000000
      evaluation_periods = null #3
      period             = null #120
    }
    net_out_scale_out = {
      enabled            = false
      threshold          = null #5000000000
      evaluation_periods = null #2
      period             = null #120
    }
    net_in_scale_in = {
      enabled            = false
      threshold          = null #120000000
      evaluation_periods = null #3
      period             = null #120
    }
    net_in_scale_out = {
      enabled            = false
      threshold          = null #5000000000
      evaluation_periods = null #2
      period             = null #120
    }
  }
}
variable "asg_scaling_policy" {
  type        = map(map(number))
  description = "Definition for the autosacling group scaling policies"
  default = {
    scale_down = {
      adjustment = -1
      cooldown   = 300
    }
    scale_up = {
      adjustment = 1
      cooldown   = 120
    }
  }
}
variable "asg_sec_grp_ingress" {
  type = list(object({
    cidr_blocks      = list(string)
    description      = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    protocol         = string
    security_groups  = list(string)
    to_port          = number
    self             = bool
  }))
  description = "A list of ingress rule as objects for the ASG security group"
  default = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTP"
      from_port        = 80
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      to_port          = 80
      self             = null
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTPS"
      from_port        = 443
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "tcp"
      security_groups  = null
      to_port          = 443
      self             = null
    }
  ]
}
variable "asg_sec_grp_egress" {
  type = list(object({
    cidr_blocks      = list(string)
    description      = string
    from_port        = number
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    protocol         = string
    security_groups  = list(string)
    to_port          = number
    self             = bool
  }))
  description = "A list of egress rule as objects for the ASG security group"
  default = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Everywhere"
      from_port        = 0
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "-1"
      security_groups  = null
      to_port          = 0
      self             = null
    }
  ]
}
