data "aws_instances" "jenkins" {
  instance_tags = {
    Name  = var.instance_tag_name_jenkins
  }

  instance_state_names = ["running", "stopped"]
}

data "aws_instances" "dev" {
  instance_tags = {
    Name  = var.instance_tag_name_dev
  }

  instance_state_names = ["running", "stopped"]
}

data "aws_instances" "prod" {
  instance_tags = {
    Name  = var.instance_tag_name_prod
  }

  instance_state_names = ["running", "stopped"]
}

data "aws_sns_topic" "this" {
  name = "alarms-topic"
}