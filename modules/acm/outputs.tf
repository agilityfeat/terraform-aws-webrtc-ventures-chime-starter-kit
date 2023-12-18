output "arn" {
  description = "Certificate ARN"
  value       = aws_acm_certificate_validation.main.certificate_arn
}

output "domain" {
  description = "The certificate associated domain"
  value       = aws_acm_certificate.main.domain_name
}
