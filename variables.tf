locals {
  # don't change this unless you want to add another kind of instance
  instance_functionality_list = ["webapp", "database"]
  instance_available_os       = ["ubuntu-20.04", "centos7"]
}

variable "instances" {
  type = map(object({ type = string, OS = string, amount = number }))
  default = {
    # when you add an instance make sure its type exists in local.instance_functionality_list
    # if it isn't terraform will raise and error
    app-1    = { type = "webapp", OS = "ubuntu-20.04", amount = 1 }
    app-2    = { type = "webapp", OS = "centos7", amount = 1 }
    database = { type = "database", OS = "centos7", amount = 1 }
  }
}

locals {
  # validating instances input here, bc I can't validate a variable using another variable:
  # terraform hasn't implemented this feature yet.
  # open issue here: https://github.com/hashicorp/terraform/issues/25609
  instance_var_ok = alltrue([
    for instance in var.instances :
    contains(local.instance_functionality_list, instance.type)
  ]) ? true : file("--> make sure the kind of instance you want to create is one of these: ${join(", ", local.instance_functionality_list)}")
  # using the function "file" bc terraform hasn't implemented a raise error feature yet
  # so, this will return an error if it's false
}

variable "recreate_instances_after_apply" {
  type    = bool
  default = false
}

locals {
  instances = {
    for instance_functionality in local.instance_functionality_list : instance_functionality => {
      for instance_name, value in var.instances : instance_name => value if value.type == instance_functionality
    }
  }

  instances_flatten = flatten([for instance_functionality in local.instances : instance_functionality])
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# can't have weird caracter like '-', ansible will have some issues with the inventory
variable "instance_tags" {
  type    = string
  default = "dev"
}


variable "aws_region" {
  default = "us-west-2"
}

variable "host_os" {
  type    = string
  default = "linux"
}

# add here your AMIs, based on the pattern => "OS_region" = "ami-someamiid"
variable "ami" {
  type = map(any)
  default = {
    # Ubuntu 20.04 LTS
    "ubuntu-20.04_us-west-2" = "ami-0ddf424f81ddb0720"
    "ubuntu-20.04_us-east-2" = "ami-0b4fa084a1e7e6f5a"

    # CentOS
    "centos7_us-west-2" = "ami-0686851c4e7b1a8e1"

    # Do this V
    "Amazon_Linux_2_AMI" = "ami-098e42ae54c764c35"

  }
}

variable "instance-state" {
  type = string
  #options we have
  default = "keep"
  # default = "stop"
  # default = "start"
  # default = "reboot"
}

variable "instance-state-map" {
  type = map(any)
  default = {
    "start"  = "start-instances"
    "stop"   = "stop-instances"
    "reboot" = "reboot-instances"

  }
}
