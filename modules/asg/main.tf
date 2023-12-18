# Key pair for ssh for debuging
resource "aws_key_pair" "main" {
  key_name   = "${var.name}-ssh-key-${var.unique_id}"
  public_key = file("${path.module}/keys/id_rsa-${var.unique_id}.pub")

  tags = merge({ Name = "${var.name}-ssh-key-${var.unique_id}" }, var.tags)
}

# Launch template
resource "aws_launch_template" "main" {
  name          = "${var.name}-launch-temp-${var.unique_id}"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  /* 
  iam_instance_profile {
    arn = aws_iam_instance_profile.main.arn
    # name = aws_iam_instance_profile.main.name
  }
  */

  block_device_mappings {
    device_name = var.root_device

    ebs {
      volume_size           = var.disk_size
      delete_on_termination = var.delete_on_termination
      encrypted             = true
    }
  }
  # vpc_security_group_ids = [aws_security_group.sg.id]
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.sg_ids
  }

  monitoring {
    enabled = var.detailed_monitoring
  }

  tags = merge({ Name = "${var.name}-launch-temp-${var.unique_id}" }, var.tags)
}

resource "aws_autoscaling_group" "main" {
  warm_pool {
    pool_state                  = var.size.warm_pool_pool_state
    min_size                    = var.size.warm_pool_prep_min_size
    max_group_prepared_capacity = var.size.warm_pool_prep_capacity
    instance_reuse_policy {
      reuse_on_scale_in = var.size.warm_pool_reuse_on_scale
    }
  }

  name                      = aws_launch_template.main.id
  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = var.size.min_size
  min_size                  = var.size.min_size
  max_size                  = var.size.max_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  force_delete              = false
  termination_policies      = var.termination_policies
  target_group_arns         = var.target_group_arns

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }
  tag {
    key                 = "Name"
    value               = "chimestarterkit"
    propagate_at_launch = true
  }
  tag {
    key                 = "Purpose"
    value               = "starterkitinstance"
    propagate_at_launch = true
  }
}

############################################################
## Control Autoscaling using CloudWatch Metrics Alarms
############################################################

# Policies for scaling up and down
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.name}-scale-down-${var.unique_id}"
  autoscaling_group_name = aws_autoscaling_group.main.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scaling_policy.scale_down.adjustment
  cooldown               = var.scaling_policy.scale_down.cooldown
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.name}-scale-up-${var.unique_id}"
  autoscaling_group_name = aws_autoscaling_group.main.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scaling_policy.scale_up.adjustment
  cooldown               = var.scaling_policy.scale_up.cooldown
}

# ASG Cloudwatch metrics alarms
resource "aws_cloudwatch_metric_alarm" "cpu_scale_in" {
  count               = var.scaling_alarms_config.cpu_scale_in.enabled == true ? 1 : 0
  alarm_name          = "${var.name}-cpu-scale-in-${var.unique_id}"
  alarm_description   = "Monitors CPU utilization for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = var.scaling_alarms_config.cpu_scale_in.threshold
  evaluation_periods  = var.scaling_alarms_config.cpu_scale_in.evaluation_periods
  period              = var.scaling_alarms_config.cpu_scale_in.period
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_scale_out" {
  count               = var.scaling_alarms_config.cpu_scale_out.enabled == true ? 1 : 0
  alarm_name          = "${var.name}-cpu-scale-out-${var.unique_id}"
  alarm_description   = "Monitors CPU utilization for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = var.scaling_alarms_config.cpu_scale_out.threshold
  evaluation_periods  = var.scaling_alarms_config.cpu_scale_out.evaluation_periods
  period              = var.scaling_alarms_config.cpu_scale_out.period
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

# Each instance type has different network limits that affect how these alarms behave
# To understand the network limits you can reference:
# 1. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html 
#    - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/general-purpose-instances.html#general-purpose-network-performance
# 2. https://cloudonaut.io/ec2-network-performance-cheat-sheet/
# Note for network metrics, they can be fine tuned based on the instance type and application load 
# - you have to run tests and check the cloudwatch metrics to see the point where the maximum network out breaks the app
# - you can also add network in based on cloudwatch metrics which have to be tested for your specific application
# to be enabled after running tests and acquiring the maximum network values
resource "aws_cloudwatch_metric_alarm" "network_out_scale_in" {
  count               = var.scaling_alarms_config.net_out_scale_in.enabled == true ? 1 : 0
  alarm_description   = "Monitors network out traffic for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "${var.name}-network-out-scale-in-${var.unique_id}"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "NetworkOut"
  threshold           = "${var.scaling_alarms_config.net_out_scale_in.threshold}"
  evaluation_periods  = "${var.scaling_alarms_config.net_out_scale_in.evaluation_periods}"
  period              = "${var.scaling_alarms_config.net_out_scale_in.period}"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
resource "aws_cloudwatch_metric_alarm" "network_out_scale_out" {
  count               = var.scaling_alarms_config.net_out_scale_out.enabled == true ? 1 : 0
  alarm_description   = "Monitors network out traffic for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "${var.name}-network-out-scale-out-${var.unique_id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "NetworkOut"
  threshold           = "${var.scaling_alarms_config.net_out_scale_out.threshold}"
  evaluation_periods  = "${var.scaling_alarms_config.net_out_scale_out.evaluation_periods}"
  period              = "${var.scaling_alarms_config.net_out_scale_out.period}"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
resource "aws_cloudwatch_metric_alarm" "network_in_scale_in" {
  count               = var.scaling_alarms_config.net_in_scale_in.enabled == true ? 1 : 0
  alarm_description   = "Monitors Network In traffic for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "${var.name}-network-in-scale-in-${var.unique_id}"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "NetworkIn"
  threshold           = "${var.scaling_alarms_config.net_in_scale_in.threshold}"
  evaluation_periods  = "${var.scaling_alarms_config.net_in_scale_in.evaluation_periods}"
  period              = "${var.scaling_alarms_config.net_in_scale_in.period}"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
resource "aws_cloudwatch_metric_alarm" "network_in_scale_out" {
  count               = var.scaling_alarms_config.net_in_scale_out.enabled == true ? 1 : 0
  alarm_description   = "Monitors Network In traffic for the ASG instances"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "${var.name}-network-in-sclae-out-${var.unique_id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "NetworkIn"
  threshold           = "${var.scaling_alarms_config.net_in_scale_out.threshold}"
  evaluation_periods  = "${var.scaling_alarms_config.net_in_scale_out.evaluation_periods}"
  period              = "${var.scaling_alarms_config.net_in_scale_out.period}"
  
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
