output "arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}

output "domain" {
  value = aws_acm_certificate.main.domain_name
}
