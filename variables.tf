variable instance_tag_name_jenkins {
  description = "Instance tag name"
}

variable instance_tag_name_dev {
  description = "Instance tag name"
}

variable instance_tag_name_prod {
  description = "Instance tag name"
}

variable alarm_email {
  description = "Email for sns topic subscription"
}

variable instance_alarms {
  description = "Alarms for instance"
  default = []
}

variable region{
  description = "AWS region"
}