variable "host_os" {
  type    = string
  default = "linux"
}

variable "instance_count" {
  default = "0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_tags" {
  type    = string
  default = "dev-node"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "ami" {
  type    = map
  default = {
    # Ubuntu 20.04 LTS
    "us-west-2" = "ami-0ddf424f81ddb0720"
    "us-east-2" = "ami-0b4fa084a1e7e6f5a"
  }
}