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