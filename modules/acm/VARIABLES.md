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
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_domain"></a> [app\_domain](#input\_app\_domain) | Domain name for the acm certificate's domain | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Project name | `string` | n/a | yes |
| <a name="input_route53_hosted_private_zone"></a> [route53\_hosted\_private\_zone](#input\_route53\_hosted\_private\_zone) | Indicates whether Route53 hosted zone is private | `bool` | `false` | no |
| <a name="input_route53_hosted_zone_id"></a> [route53\_hosted\_zone\_id](#input\_route53\_hosted\_zone\_id) | Hosted zone id from Route53 | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | The additional SANs for the acm certificate - subject name alternatives | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Certificate ARN |
| <a name="output_domain"></a> [domain](#output\_domain) | The certificate associated domain |
<!-- END_TF_DOCS -->