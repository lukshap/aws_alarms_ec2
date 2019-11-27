resource "aws_cloudwatch_metric_alarm" "jenkins" {
  count                     = length(var.instance_alarms)
  alarm_name                = format("%s_%s", var.instance_tag_name_jenkins, lookup(element(var.instance_alarms, count.index), "metric_name"))
  comparison_operator       = lookup(element(var.instance_alarms, count.index), "comparison_operator")
  evaluation_periods        = lookup(element(var.instance_alarms, count.index), "evaluation_periods")
  metric_name               = lookup(element(var.instance_alarms, count.index), "metric_name")
  namespace                 = lookup(element(var.instance_alarms, count.index), "namespace")
  period                    = lookup(element(var.instance_alarms, count.index), "period")
  statistic                 = lookup(element(var.instance_alarms, count.index), "statistic")
  threshold                 = lookup(element(var.instance_alarms, count.index), "threshold")
  alarm_description         = lookup(element(var.instance_alarms, count.index), "alarm_description")
  alarm_actions             = [aws_sns_topic.alarm.arn]
  insufficient_data_actions = []

  dimensions = {
    InstanceId = data.aws_instances.jenkins.ids[0]
  }
}

resource "aws_cloudwatch_metric_alarm" "dev" {
  count                     = length(var.instance_alarms)
  alarm_name                = format("%s_%s", var.instance_tag_name_dev, lookup(element(var.instance_alarms, count.index), "metric_name"))
  comparison_operator       = lookup(element(var.instance_alarms, count.index), "comparison_operator")
  evaluation_periods        = lookup(element(var.instance_alarms, count.index), "evaluation_periods")
  metric_name               = lookup(element(var.instance_alarms, count.index), "metric_name")
  namespace                 = lookup(element(var.instance_alarms, count.index), "namespace")
  period                    = lookup(element(var.instance_alarms, count.index), "period")
  statistic                 = lookup(element(var.instance_alarms, count.index), "statistic")
  threshold                 = lookup(element(var.instance_alarms, count.index), "threshold")
  alarm_description         = lookup(element(var.instance_alarms, count.index), "alarm_description")
  alarm_actions             = [aws_sns_topic.alarm.arn]
  insufficient_data_actions = []

  dimensions = {
    InstanceId = data.aws_instances.dev.ids[0]
  }
}

resource "aws_cloudwatch_metric_alarm" "prod" {
  count                     = length(var.instance_alarms)
  alarm_name                = format("%s_%s", var.instance_tag_name_prod, lookup(element(var.instance_alarms, count.index), "metric_name"))
  comparison_operator       = lookup(element(var.instance_alarms, count.index), "comparison_operator")
  evaluation_periods        = lookup(element(var.instance_alarms, count.index), "evaluation_periods")
  metric_name               = lookup(element(var.instance_alarms, count.index), "metric_name")
  namespace                 = lookup(element(var.instance_alarms, count.index), "namespace")
  period                    = lookup(element(var.instance_alarms, count.index), "period")
  statistic                 = lookup(element(var.instance_alarms, count.index), "statistic")
  threshold                 = lookup(element(var.instance_alarms, count.index), "threshold")
  alarm_description         = lookup(element(var.instance_alarms, count.index), "alarm_description")
  alarm_actions             = [aws_sns_topic.alarm.arn]
  insufficient_data_actions = []

  dimensions = {
    InstanceId = data.aws_instances.prod.ids[0]
  }
}

resource "aws_sns_topic" "alarm" {
  name = "alarms-topic"
  delivery_policy = "${data.template_file.delivery_policy.rendered}"
  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarm_email}"
  }
}