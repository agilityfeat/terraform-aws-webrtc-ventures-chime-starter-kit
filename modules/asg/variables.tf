variable "name" {
  type        = string
  description = "The current name assined to this project"
}
variable "unique_id" {
  type        = string
  description = "Module resource unique id appended on all resource names"
}
variable "vpc_id" {
  type        = string
  description = "The VPC id used for this setup - currently using the default VPC - for tight security create your custom vpc"
}
variable "ami_id" {
  type        = string
  description = "The AMI ID for the instances"
}
variable "delete_on_termination" {
  type        = bool
  description = "Whether to delete attached EBS volument on termination of the instance"
  default     = true
}
variable "detailed_monitoring" {
  type        = bool
  description = "Whether to enable detailed instance monitoring"
  default     = true
}
variable "root_device" {
  type        = string
  description = "The root device name"
  default     = "/dev/xvda" # amazon linux
}
variable "instance_type" {
  type        = string
  description = "The instance type that will be used to launch ASG instances"
}
variable "size" {
  type = object({
    min_size                 = number
    max_size                 = number
    warm_pool_pool_state     = string
    warm_pool_prep_capacity  = number
    warm_pool_prep_min_size  = number
    warm_pool_reuse_on_scale = bool
  })
  description = "Autoscaling group size configuration"
}
variable "scaling_policy" {
  type        = map(map(number))
  description = "(optional) describe your variable"
  default = {
    scale_down = {
      adjustment = -1
      cooldown   = 300
    }
    scale_up = {
      adjustment = 1
      cooldown   = 60
    }
  }
}
variable "scaling_alarms_config" {
  type = map(object({
    enabled            = bool
    threshold          = number
    evaluation_periods = number
    period             = number
  }))
  description = "The scaling configuration"
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
variable "health_check_type" {
  type        = string
  description = "The healthcheck type of the autoscaling group [ELB or EC2]"
  default     = "ELB"
}
variable "health_check_grace_period" {
  type        = number
  description = "The healthcheck grace perio in seconds"
  default     = 300
}
variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ids for the ASG group"
}
variable "termination_policies" {
  type        = list(string)
  description = "Termination policies"
  default     = ["OldestInstance"]
}
variable "target_group_arns" {
  type        = list(string)
  description = "Target group arns for the Application or Network loadbalancer"
}
variable "sg_ids" {
  type        = list(string)
  description = "Additional security groups for the autosacling group"
}
variable "disk_size" {
  type        = number
  description = "Current EBS volume"
  default     = 32
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
