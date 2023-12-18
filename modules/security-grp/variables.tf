variable "name" {
  type        = string
  description = "Project name"
}
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "unique_id" {
  type        = string
  description = "Unique ID for this module"
}
variable "ingress_rules" {
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
  description = "Ingress security group rules"
}

variable "egress_rules" {
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
  description = "Egress security group rules"
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
