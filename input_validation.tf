
locals {
  # don't change this unless you want to add another kind of instance
  instance_functionality_list = ["webapp", "database"]
  instance_available_os       = ["ubuntu-20.04", "centos7"]
}

locals {
  # validating instances input here
  # bc I can't validate using "validate" meta argument due to I have to use another variables
  # terraform hasn't implemented this feature yet.
  # open issue here: https://github.com/hashicorp/terraform/issues/25609
  instance_var_ok = alltrue([
    for instance in var.instances :
    contains(local.instance_functionality_list, instance.type)
  ]) ? true : file("--> make sure the kind of instance you want to create is one of these: ${join(", ", local.instance_functionality_list)}")
  # using the function "file" bc terraform hasn't implemented a raise error feature yet
  # so, this will return an error if it's false

  instance_var_OS_ok = alltrue([
    for instance in var.instances :
    contains(local.instance_available_os, instance.OS)
  ]) ? true : file("--> make sure the OS of the instances you want to create is one of these: ${join(", ", local.instance_available_os)}")
}
