variable "instance_count" {
  default = "2"
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

variable "ami" {
  type = map(any)
  default = {
    # Ubuntu 20.04 LTS
    "us-west-2" = "ami-0ddf424f81ddb0720"
    "us-east-2" = "ami-0b4fa084a1e7e6f5a"
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
