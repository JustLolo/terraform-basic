variable "instance_count" {
  default = "1"
}

variable "instances" {
  type = map(object({ type = string, OS = string, amount = number }))
  # type = map(object({ type = local.instance_type_dict, OS = string, amount = number }))
  default = {
    app-1    = { type = "webapp", OS = "centos", amount = 1 }
    app-2    = { type = "webapp", OS = "centos", amount = 1 }
    database = { type = "database", OS = "centos", amount = 1 }
    # app-1      = { name = "app", OS = "centos", amount = 1 }
    # app-2      = { name = "app", OS = "centos", amount = 1 }
    # database = { name = "database", OS = "centos", amount = 1 }

  }

  validation {
    condition = alltrue([
      for instance in var.instances :
      instance.type == "database" || instance.type == "webapp"
    ])
    error_message = "the instance type has to be either \"database\" or \"webapp\""
  }
}

variable "recreate_instances_after_apply" {
  type    = bool
  default = false
}

locals {
  # instance_type_dict = {
  #   webapp   = { type = "webapp", ASG = true, OS = "centos" }
  #   database = { type = "database", ASG = false, OS = "centos" }
  # }
  webapps_instances = {
    for webapp, value in var.instances : webapp => value if value.type == "webapp"
  }

  database_instances = {
    for database, value in var.instances : database => value if value.type == "database"
  }
}



# locals {
#   # type = map(object({ name = string, OS = string, amount = number }))
#   # type = map(object({ type = string, ASG = bool, OS = string }))
#   default = {



#     # app      = { name = "app", OS = "centos", amount = 1 }
#     # database = { name = "database", OS = "centos", amount = 1 }

#   }
# }

# variable "instances" {
#   # type = map(object({ name = string, OS = string, amount = number }))
#   type = map(object({ type = local.instance_type_dict, OS = string, amount = number }))
#   default = {
#     # app      = { name = "app", OS = "centos", amount = 1 }
#     # database = { name = "database", OS = "centos", amount = 1 }

#   }
# }

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

variable "ami" {
  type = map(any)
  default = {
    # Ubuntu 20.04 LTS
    "us-west-2" = "ami-0ddf424f81ddb0720"
    "us-east-2" = "ami-0b4fa084a1e7e6f5a"

    #the name says everything
    "CentOS7-us-west-2"  = "ami-0686851c4e7b1a8e1"
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
