<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https_main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_tls_cert_arn"></a> [alb\_tls\_cert\_arn](#input\_alb\_tls\_cert\_arn) | The ARN of the certificate that the ALB uses for https | `string` | n/a | yes |
| <a name="input_app_domain"></a> [app\_domain](#input\_app\_domain) | The effective ALB domain name, used to create a CNAME record | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | Current AWS account id | `string` | n/a | yes |
| <a name="input_aws_elb_account_id"></a> [aws\_elb\_account\_id](#input\_aws\_elb\_account\_id) | Current ELB account id, varies per AWS region | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Current AWS region | `string` | n/a | yes |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused | `number` | `300` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Whether to protect the LoadBalancer from deletion. | `bool` | `false` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | Whether healthchecking is enabled | `bool` | `true` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | Number of consecutive health check successes required before considering a target healthy. The range is 2-10. | `number` | `2` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | Approximate amount of time, in seconds, between health checks of an individual target. The range is 5-300. | `number` | `70` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | Response codes to use when checking for a healthy responses from a target | `string` | `"200,201,300,301"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Destination for the health check request | `string` | n/a | yes |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port the load balancer uses when performing health checks on targets | `string` | `"80"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | Protocol the load balancer uses when performing health checks on targets. | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | Amount of time, in seconds, during which no response from a target means a failed health check. The range is 2–120 seconds. | `string` | `"60"` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | Number of consecutive health check failures required before considering a target unhealthy. | `string` | `"5"` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | Idle timeout for the LoadBalancer [0 - 4000] seconds | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether to create a private LoadBalancer. | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6 | `string` | `"ipv4"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Type of the Elastic Loadbalancer | `string` | `"application"` | no |
| <a name="input_name"></a> [name](#input\_name) | Project name | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | Port on which targets receive traffic, unless overridden when registering a specific target. | `number` | `80` | no |
| <a name="input_preserve_host_header"></a> [preserve\_host\_header](#input\_preserve\_host\_header) | Whether to preserve host header on the incoming requests. | `bool` | `true` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP\_UDP, TLS, or UDP | `string` | `"HTTP"` | no |
| <a name="input_route53_hosted_zone_id"></a> [route53\_hosted\_zone\_id](#input\_route53\_hosted\_zone\_id) | Route53 hosted zone id | `string` | `null` | no |
| <a name="input_sg_ids"></a> [sg\_ids](#input\_sg\_ids) | A list of security group IDs. | `list(string)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Comma separated list of subnet IDs | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | Type of target that you must specify when registering targets with this target group. https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html | `string` | `"instance"` | no |
| <a name="input_unique_id"></a> [unique\_id](#input\_unique\_id) | Unique identifier to be appended on resource names. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the current VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The LoadBalancer DNS name from created by ELB. Used to map the domain name for accessing the application. |
| <a name="output_domain"></a> [domain](#output\_domain) | LoadBalancer mapped domain/subdomain. Depends on whether Rout53 was used or not. |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | LoadBalancer main target group arn |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | LoadBalancer main target group name |
<!-- END_TF_DOCS -->