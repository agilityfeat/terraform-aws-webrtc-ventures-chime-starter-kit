variable "name" {
  type        = string
  description = "Project name"
}
variable "app_domain" {
  type        = string
  description = "Domain name for the acm certificate's domain"
}
variable "subject_alternative_names" {
  type        = list(string)
  description = "The additional SANs for the acm certificate - subject name alternatives"
  default     = null
}
variable "route53_hosted_zone_id" {
  type        = string
  description = "Hosted zone id from Route53"
}
variable "route53_hosted_private_zone" {
  type        = bool
  description = "Indicates whether Route53 hosted zone is private"
  default     = false
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
}
