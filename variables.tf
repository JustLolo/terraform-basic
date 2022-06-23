variable "host_os" {
  type    = string
  default = "linux"
}

variable "instance_count" {
  default = "1"
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
    "us-east-2" = "ami-0010d386b82bc06f0"
    "us-west-2" = "ami-0a99cf9e5c850139c"
  }
}