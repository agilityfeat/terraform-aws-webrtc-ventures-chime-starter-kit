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
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | Egress security group rules | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Ingress security group rules | <pre>list(object({<br>    cidr_blocks      = list(string)<br>    description      = string<br>    from_port        = number<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    protocol         = string<br>    security_groups  = list(string)<br>    to_port          = number<br>    self             = bool<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Project name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_unique_id"></a> [unique\_id](#input\_unique\_id) | Unique ID for this module | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Security ID |
| <a name="output_name"></a> [name](#output\_name) | Security group name |
<!-- END_TF_DOCS -->