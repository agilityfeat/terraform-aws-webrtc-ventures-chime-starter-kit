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
| [aws_autoscaling_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.cpu_scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.network_in_scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.network_in_scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.network_out_scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.network_out_scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_launch_template.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The AMI ID for the instances | `string` | n/a | yes |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether to delete attached EBS volument on termination of the instance | `bool` | `true` | no |
| <a name="input_detailed_monitoring"></a> [detailed\_monitoring](#input\_detailed\_monitoring) | Whether to enable detailed instance monitoring | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Current EBS volume | `number` | `32` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | The healthcheck grace perio in seconds | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | The healthcheck type of the autoscaling group [ELB or EC2] | `string` | `"ELB"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type that will be used to launch ASG instances | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The current name assined to this project | `string` | n/a | yes |
| <a name="input_root_device"></a> [root\_device](#input\_root\_device) | The root device name | `string` | `"/dev/xvda"` | no |
| <a name="input_scaling_alarms_config"></a> [scaling\_alarms\_config](#input\_scaling\_alarms\_config) | The scaling configuration | <pre>map(object({<br>    enabled            = bool<br>    threshold          = number<br>    evaluation_periods = number<br>    period             = number<br>  }))</pre> | <pre>{<br>  "cpu_scale_in": {<br>    "enabled": true,<br>    "evaluation_periods": 3,<br>    "period": 120,<br>    "threshold": 10<br>  },<br>  "cpu_scale_out": {<br>    "enabled": true,<br>    "evaluation_periods": 2,<br>    "period": 120,<br>    "threshold": 75<br>  },<br>  "net_in_scale_in": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_in_scale_out": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_out_scale_in": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  },<br>  "net_out_scale_out": {<br>    "enabled": false,<br>    "evaluation_periods": null,<br>    "period": null,<br>    "threshold": null<br>  }<br>}</pre> | no |
| <a name="input_scaling_policy"></a> [scaling\_policy](#input\_scaling\_policy) | (optional) describe your variable | `map(map(number))` | <pre>{<br>  "scale_down": {<br>    "adjustment": -1,<br>    "cooldown": 300<br>  },<br>  "scale_up": {<br>    "adjustment": 1,<br>    "cooldown": 60<br>  }<br>}</pre> | no |
| <a name="input_sg_ids"></a> [sg\_ids](#input\_sg\_ids) | Additional security groups for the autosacling group | `list(string)` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Autoscaling group size configuration | <pre>object({<br>    min_size                 = number<br>    max_size                 = number<br>    warm_pool_pool_state     = string<br>    warm_pool_prep_capacity  = number<br>    warm_pool_prep_min_size  = number<br>    warm_pool_reuse_on_scale = bool<br>  })</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ids for the ASG group | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | Target group arns for the Application or Network loadbalancer | `list(string)` | n/a | yes |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | Termination policies | `list(string)` | <pre>[<br>  "OldestInstance"<br>]</pre> | no |
| <a name="input_unique_id"></a> [unique\_id](#input\_unique\_id) | Module resource unique id appended on all resource names | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC id used for this setup - currently using the default VPC - for tight security create your custom vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Autoscaling group name |
<!-- END_TF_DOCS -->