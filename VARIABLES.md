<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/acm | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_alb_security_grp"></a> [alb\_security\_grp](#module\_alb\_security\_grp) | ./modules/security-group | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | ./modules/asg | n/a |
| <a name="module_asg_security_grp"></a> [asg\_security\_grp](#module\_asg\_security\_grp) | ./modules/security-grp | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_cert_arn"></a> [acm\_cert\_arn](#input\_acm\_cert\_arn) | TLS certificate ARN from the AWS Certicate Manager console if you created the TLS certificate manually. Depends on the `use_route53_hostedzone_for_acm` variable. Format: arn:aws:acm:REGION:EXAMPLE:certificate/EXAMPLE423b3-EXAMPLE-CERTIFICATE | `string` | `null` | no |
| <a name="input_acm_unique_id"></a> [acm\_unique\_id](#input\_acm\_unique\_id) | Unique id to be appended on ACM resource names. | `string` | n/a | yes |
| <a name="input_alb_deregistration_delay"></a> [alb\_deregistration\_delay](#input\_alb\_deregistration\_delay) | Amount time in seconds for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused | `number` | `300` | no |
| <a name="input_alb_enable_deletion_protection"></a> [alb\_enable\_deletion\_protection](#input\_alb\_enable\_deletion\_protection) | Whether to protect the LoadBalancer from deletion. | `bool` | `false` | no |
| <a name="input_alb_health_check_enabled"></a> [alb\_health\_check\_enabled](#input\_alb\_health\_check\_enabled) | Whether health checking is enabled | `bool` | `true` | no |
| <a name="input_alb_health_check_healthy_threshold"></a> [alb\_health\_check\_healthy\_threshold](#input\_alb\_health\_check\_healthy\_threshold) | Number of consecutive health check successes required before considering a target healthy. The range is 2-10. | `number` | `2` | no |
| <a name="input_alb_health_check_interval"></a> [alb\_health\_check\_interval](#input\_alb\_health\_check\_interval) | Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300. | `number` | `70` | no |
| <a name="input_alb_health_check_matcher"></a> [alb\_health\_check\_matcher](#input\_alb\_health\_check\_matcher) | Response codes to use when checking for a healthy responses from a target | `string` | `"200,201,301,302"` | no |
| <a name="input_alb_health_check_path"></a> [alb\_health\_check\_path](#input\_alb\_health\_check\_path) | Destination for the health check request | `string` | `"/"` | no |
| <a name="input_alb_health_check_port"></a> [alb\_health\_check\_port](#input\_alb\_health\_check\_port) | The port the load balancer uses when performing health checks on targets | `string` | `"80"` | no |
| <a name="input_alb_health_check_protocol"></a> [alb\_health\_check\_protocol](#input\_alb\_health\_check\_protocol) | Protocol the load balancer uses when performing health checks on targets. | `string` | `"HTTP"` | no |
| <a name="input_alb_health_check_timeout"></a> [alb\_health\_check\_timeout](#input\_alb\_health\_check\_timeout) | Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds. | `string` | `"60"` | no |
| <a name="input_alb_health_check_unhealthy_threshold"></a> [alb\_health\_check\_unhealthy\_threshold](#input\_alb\_health\_check\_unhealthy\_threshold) | Number of consecutive health check failures required before considering a target unhealthy. | `string` | `"5"` | no |
| <a name="input_alb_idle_timeout"></a> [alb\_idle\_timeout](#input\_alb\_idle\_timeout) | Idle timeout for the LoadBalancer [0 - 4000] seconds | `number` | `60` | no |
| <a name="input_alb_internal"></a> [alb\_internal](#input\_alb\_internal) | Whether to create a private LoadBalancer. | `bool` | `false` | no |
| <a name="input_alb_ip_address_type"></a> [alb\_ip\_address\_type](#input\_alb\_ip\_address\_type) | The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6 | `string` | `"ipv4"` | no |
| <a name="input_alb_load_balancer_type"></a> [alb\_load\_balancer\_type](#input\_alb\_load\_balancer\_type) | Type of the Elastic Loadbalancer | `string` | `"application"` | no |
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | Port on which targets receive traffic, unless overridden when registering a specific target. | `number` | `80` | no |
| <a name="input_alb_preserve_host_header"></a> [alb\_preserve\_host\_header](#input\_alb\_preserve\_host\_header) | Whether to preserve host header on the incoming requests. | `bool` | `true` | no |
| <a name="input_alb_sec_grp_egress"></a> [alb\_sec\_grp\_egress](#input\_alb\_sec\_grp\_egress) | A list of egress rule as objects for the ALB security group | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_alb_sec_grp_ingress"></a> [alb\_sec\_grp\_ingress](#input\_alb\_sec\_grp\_ingress) | A list of ingress rule as objects for the ALB security group | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_alb_target_type"></a> [alb\_target\_type](#input\_alb\_target\_type) | Type of target that you must specify when registering targets with this target group. https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html | `string` | `"instance"` | no |
| <a name="input_alb_unique_id"></a> [alb\_unique\_id](#input\_alb\_unique\_id) | The unique string to identify LoadBalancer module resources; appended on the resource names. | `string` | n/a | yes |
| <a name="input_app_domain"></a> [app\_domain](#input\_app\_domain) | If using Route53 supply the domain on which the application will be accessed. It must be the same domain/subsdomain name used to generete the ACM certificate. | `string` | `null` | no |
| <a name="input_asg_ami_id"></a> [asg\_ami\_id](#input\_asg\_ami\_id) | The AMI ID from the product configuration page on AWS Marketplace. You must first subscribe to the product and then click on configuration button to view the AMI details. | `string` | n/a | yes |
| <a name="input_asg_delete_on_termination"></a> [asg\_delete\_on\_termination](#input\_asg\_delete\_on\_termination) | Whether to delete attached ELB volume on instance termination | `bool` | `true` | no |
| <a name="input_asg_detailed_monitoring"></a> [asg\_detailed\_monitoring](#input\_asg\_detailed\_monitoring) | Whether to enable detailed monitoring of the instances in the ASG | `bool` | `true` | no |
| <a name="input_asg_disk_size"></a> [asg\_disk\_size](#input\_asg\_disk\_size) | The disk size allocated for each instance | `number` | `40` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | The disk size allocated for each instance | `number` | `300` | no |
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | The healthcheck type used by ASG. Can be ELB or EC2 | `string` | `"ELB"` | no |
| <a name="input_asg_instance_type"></a> [asg\_instance\_type](#input\_asg\_instance\_type) | The instance type used by ASG on the launced instances | `string` | `"t2.small"` | no |
| <a name="input_asg_root_device"></a> [asg\_root\_device](#input\_asg\_root\_device) | The root device for the instances. Default /dev/xvda for Amazon Linux instances used for this setup. | `string` | `"/dev/xvda"` | no |
| <a name="input_asg_scaling_alarms_config"></a> [asg\_scaling\_alarms\_config](#input\_asg\_scaling\_alarms\_config) | A map of objects with values for the Autosacling group alarms configurations. | <pre>map(object({<br>    enabled            = bool<br>    threshold          = number<br>    evaluation_periods = number<br>    period             = number<br>  }))</pre> | <pre>{<br>  "cpu_scale_in": {<br>    "enabled": true,<br>    "evaluation_periods": 3,<br>    "period": 120,<br>    "threshold": 10<br>  },<br>  "cpu_scale_out": {<br>    "enabled": true,<br>    "evaluation_periods": 2,<br>    "period": 120,<br>    "threshold": 75<br>  },<br>  "net_in_scale_in": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_in_scale_out": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_out_scale_in": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_out_scale_out": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  }<br>}</pre> | no |
| <a name="input_asg_scaling_policy"></a> [asg\_scaling\_policy](#input\_asg\_scaling\_policy) | Definition for the autosacling group scaling policies | `map(map(number))` | <pre>{<br>  "scale_down": {<br>    "adjustment": -1,<br>    "cooldown": 300<br>  },<br>  "scale_up": {<br>    "adjustment": 1,<br>    "cooldown": 120<br>  }<br>}</pre> | no |
| <a name="input_asg_sec_grp_egress"></a> [asg\_sec\_grp\_egress](#input\_asg\_sec\_grp\_egress) | A list of egress rule as objects for the ASG security group | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_asg_sec_grp_ingress"></a> [asg\_sec\_grp\_ingress](#input\_asg\_sec\_grp\_ingress) | A list of ingress rule as objects for the ASG security group | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_asg_size_configuration"></a> [asg\_size\_configuration](#input\_asg\_size\_configuration) | The configuration for the ASG size. The warmpool variable define the instances that will be prepared in adavance and their waiting states. | <pre>object({<br>    max_size                 = number<br>    min_size                 = number<br>    warm_pool_pool_state     = string # ["Hibernated" "Stopped" "Running" "Hibernated"]<br>    warm_pool_prep_capacity  = number<br>    warm_pool_prep_min_size  = number<br>    warm_pool_reuse_on_scale = bool<br>  })</pre> | <pre>{<br>  "max_size": 2,<br>  "min_size": 1,<br>  "warm_pool_pool_state": "Hibernated",<br>  "warm_pool_prep_capacity": 1,<br>  "warm_pool_prep_min_size": 1,<br>  "warm_pool_reuse_on_scale": true<br>}</pre> | no |
| <a name="input_asg_unique_id"></a> [asg\_unique\_id](#input\_asg\_unique\_id) | The unique string to identify ASG module resources; appended on the resource names. | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | Current AWS account ID | `string` | n/a | yes |
| <a name="input_aws_elb_account_id"></a> [aws\_elb\_account\_id](#input\_aws\_elb\_account\_id) | Current AWS ELB Account ID obtain the ID for your region from https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the resources will be provisioned | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Project name used to form part of most resource names. This will identify your created resources. | `string` | n/a | yes |
| <a name="input_route53_hosted"></a> [route53\_hosted](#input\_route53\_hosted) | If using Route53, supply the Route53 zone details | <pre>object({<br>    zone_id    = string<br>    is_private = bool<br>  })</pre> | n/a | yes |
| <a name="input_use_route53_hostedzone_for_acm"></a> [use\_route53\_hostedzone\_for\_acm](#input\_use\_route53\_hostedzone\_for\_acm) | Indicates whether you are using a route53 hosted zone created in the current account you are using | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Main VPC CIDR | `string` | `"172.18.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Names assigned to the vpc | `string` | `"vpc"` | no |
| <a name="input_vpc_private_subnets"></a> [vpc\_private\_subnets](#input\_vpc\_private\_subnets) | VPC Private subnet CIDRs | `list(string)` | <pre>[<br>  "172.18.48.0/20",<br>  "172.18.64.0/20",<br>  "172.18.80.0/20"<br>]</pre> | no |
| <a name="input_vpc_public_subnets"></a> [vpc\_public\_subnets](#input\_vpc\_public\_subnets) | VPC Public subnet CIDRs | `list(string)` | <pre>[<br>  "172.18.96.0/20",<br>  "172.18.112.0/20",<br>  "172.18.128.0/20"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_domain"></a> [application\_domain](#output\_application\_domain) | The domain name mapped to `lb_dns_value`. Output if a Route53 hosted zone was used, if not it will contain null. |
| <a name="output_lb_dns_value"></a> [lb\_dns\_value](#output\_lb\_dns\_value) | The loadbalancer DNS name created by ElasticLoadbalancer. Since we are using https, this must be mapped to the corresponding domain/sudomain. |
<!-- END_TF_DOCS -->