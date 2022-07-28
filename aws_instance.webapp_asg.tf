
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zone#filter
# # https://www.bogotobogo.com/DevOps/Terraform/Terraform-Introduction-AWS-ASG-Modules.php
# # https://awstip.com/aws-how-to-use-terraform-to-create-a-subnet-per-availability-zone-8f7236378f93

data "aws_availability_zones" "available" {}

resource "aws_subnet" "webapp_asg" {
  # create an input variable where you specify the amount of availability zones
  # create a conditional (if amount is higher than length, raise an error)
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.mtc_vpc.id

  # create some kind of validator such as the first 10 will be used for webapp-asg
  # it's not problable that count will be higher than 10
  # I have to document this!!!
  cidr_block              = cidrsubnet(aws_vpc.mtc_vpc.cidr_block, 8, 245 + count.index) # 10.123.245-255.0/8
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "webapp-asg_subnet"
  }
}

resource "aws_launch_template" "webapp_asg" {
  for_each = { for key, instance in var.instances : key => instance if instance.type == "webapp" && (tostring(instance.ASG) == "true") }
  # ...instance configuration...
  name                   = "webapp_asg_launch_template"
  description            = "Random Template Description"
  image_id               = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
  instance_type          = each.value.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  # bc this will be scaling, we don't need them if they aren't working
  instance_initiated_shutdown_behavior = "terminate"

  key_name = aws_key_pair.mtc_auth.id
  user_data = base64encode(
    <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS" > index.html
              echo "I am a ${each.key} instance with ASG" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
  )

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${each.key}"
    }
  }
}

# resource "aws_instance" "webapp_asg" {
#   #used tostring function bc thisis experimental, and this output is not going to change
#   for_each = { for key, instance in var.instances : key => instance if instance.type == "webapp" && (tostring(instance.ASG) == "true") }

#   # ami                    = data.aws_ami.server_ami.id
#   ami                    = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
#   instance_type          = each.value.ec2_instance_type
#   vpc_security_group_ids = [aws_security_group.mtc_sg.id]
#   subnet_id              = aws_subnet.mtc_public_subnet.id
#   key_name               = aws_key_pair.mtc_auth.id

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, Terraform & AWS" > index.html
#               echo "I am a ${each.key} instance with ASG" > index.html
#               nohup busybox httpd -f -p 80 &
#               EOF

#   lifecycle {
#     #this resource will use ASG, we need it always online
#     create_before_destroy = true
#   }

#   root_block_device {
#     volume_size = 8
#     volume_type = "standard"
#   }

#   tags = {
#     Name = "${each.key}"
#   }

#   depends_on = [null_resource.input_validator]
# }

# # Retrieve the AZ where we want to create network resources
# # This must be in the region selected on the AWS provider.
# data "aws_availability_zone" "example" {
#   name = "eu-central-1a"
# }

# # asg -> auto scaling group
# resource "aws_instance" "webapp_asg" {
#   #used tostring function bc thisis experimental, and this output is not going to change
#   for_each = { for key, instance in var.instances : key => instance if instance.type == "webapp" && (tostring(instance.ASG) == "true") }

#   # ami                    = data.aws_ami.server_ami.id
#   ami                    = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
#   instance_type          = each.value.ec2_instance_type
#   vpc_security_group_ids = [aws_security_group.mtc_sg.id]
#   subnet_id              = aws_subnet.mtc_public_subnet.id
#   key_name               = aws_key_pair.mtc_auth.id

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, Terraform & AWS" > index.html
#               echo "I am a ${each.key} instance with ASG" > index.html
#               nohup busybox httpd -f -p 80 &
#               EOF

#   lifecycle {
#     #this resource will use ASG, we need it always online
#     create_before_destroy = true
#   }

#   root_block_device {
#     volume_size = 8
#     volume_type = "standard"
#   }

#   tags = {
#     Name = "${each.key}"
#   }

#   depends_on = [null_resource.input_validator]
# }

