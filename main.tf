locals {
  name-prefix = lower("${var.org}-${var.proj}-${var.env}") // prefix for naming resources
}

data "aws_region" "current" {}


resource "aws_launch_template" "asg" {
  name = "${local.name-prefix}-${var.lt.name}"
  image_id = var.lt.ami_id
  instance_type = var.lt.instance_type
}

resource "aws_autoscaling_group" "asg" {
  name = "${local.name-prefix}-${var.asg.name}"
  vpc_zone_identifier = var.asg.subnet_id
  desired_capacity = var.asg.desired_size
  min_size = var.asg.min_size
  max_size = var.asg.max_size
  launch_template {
    id = aws_launch_template.asg.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_traffic_source_attachment" "asg" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  traffic_source {
    identifier = var.asg.lb_tg_arn
    type = "elbv2"
  }
}
