locals {
  # don't change this unless you want to add other kind of instances
  instance_functionality_list = ["webapp", "database"]
  instance_available_os       = ["ubuntu-20.04", "centos7"]
}

resource "null_resource" "input_validator" {
  lifecycle {
    # "functionality" validator
    precondition {
      condition = alltrue([for instance in var.instances :
      contains(local.instance_functionality_list, instance.type)]) == true

      error_message = <<EOT
       one or more invalid functionality were used in var.instances, please use only one or more of the following:
 - "${join("\"\n - \"", local.instance_functionality_list)}"
       EOT
    }

    # "OS" validator
    precondition {
      condition = alltrue([for instance in var.instances :
      contains(local.instance_available_os, instance.OS)]) == true

      error_message = <<EOT
       one or more invalid OS were used in var.instances, please use only one or more of the following:
 - "${join("\"\n - \"", local.instance_available_os)}"
       EOT
    }
  }

  triggers = {
    input_changed = md5(jsonencode(var.instances))
  }
}
