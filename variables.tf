terraform {
  #needed for the optional ASG variable, From Terraform v0.14
  experiments = [module_variable_optional_attrs]
}

variable "instances" {
  type = map(object({ type = string, OS = string, amount = number, ec2_instance_type = string, ASG = optional(bool) }))
  # type = map(any)
  default = {
    # when you add an instance make sure its type and OS is checked in input_validator.tf
    # if it isn't terraform will raise and error
    # input structure { type = string, OS = string, amount = number, ec2_instance_type = string , ASG = bool (optional)}))
    # ASG = Enable Auto Scaling Group, it has to be "webapp" type, if it isn't, this will be ignored
    app-1    = { type = "webapp", OS = "ubuntu-20.04", amount = 1, ec2_instance_type = "t2.micro", ASG = true }
    app-2    = { type = "webapp", OS = "centos7", amount = 1, ec2_instance_type = "t2.micro" }
    database = { type = "database", OS = "centos7", amount = 1, ec2_instance_type = "t2.micro" }
  }
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
locals {
  ami = {
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
