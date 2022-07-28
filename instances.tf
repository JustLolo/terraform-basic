resource "aws_instance" "webapp" {
  #used tostring function bc thisis experimental, and this output is not going to change
  for_each = { for key, instance in var.instances : key => instance if instance.type == "webapp" && !(tostring(instance.ASG) == "true") }

  # ami                    = data.aws_ami.server_ami.id
  ami                    = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
  instance_type          = each.value.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  key_name               = aws_key_pair.mtc_auth.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS" > index.html
              echo "I am a ${each.key} instance" > index.html
              nohup busybox httpd -f -p 80 &
              EOF

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  tags = {
    Name = "${each.key}"
    # Name = "${var.instance_tags}-${count.index + 1}"
  }

  depends_on = [null_resource.input_validator]
}

# asg -> auto scaling group
resource "aws_instance" "webapp_asg" {
  #used tostring function bc thisis experimental, and this output is not going to change
  for_each = { for key, instance in var.instances : key => instance if instance.type == "webapp" && (tostring(instance.ASG) == "true") }

  # ami                    = data.aws_ami.server_ami.id
  ami                    = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
  instance_type          = each.value.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  key_name               = aws_key_pair.mtc_auth.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS" > index.html
              echo "I am a ${each.key} instance with ASG" > index.html
              nohup busybox httpd -f -p 80 &
              EOF

  lifecycle {
    #this resource will use ASG, we need it always online
    create_before_destroy = true
  }

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  tags = {
    Name = "${each.key}"
  }

  depends_on = [null_resource.input_validator]
}

resource "aws_instance" "database" {
  #used tostring function bc thisis experimental, and this output is not going to change
  for_each = { for key, instance in var.instances : key => instance if instance.type == "database" }

  ami                    = lookup(local.ami, join("_", [each.value.OS, var.aws_region]))
  instance_type          = each.value.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  key_name               = aws_key_pair.mtc_auth.id

  # user_data = file("userdata.tpl")

  # I'll be testing, so, I'll recreate the instance every time i run terraform apply
  # user_data                   = var.recreate_instances_after_apply ? "echo ${timestamp()} &> /dev/null " : ""
  # user_data_replace_on_change = var.recreate_instances_after_apply

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform & AWS" > index.html
              echo "I am a ${each.key} instance" > index.html
              nohup busybox httpd -f -p 80 &
              EOF

  lifecycle {
    # create_before_destroy = try(each.value.type == "webapp" && each.value.ASG == true, false)
  }

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  tags = {
    Name = "${each.key}"
    # Name = "${var.instance_tags}-${count.index + 1}"
  }

  depends_on = [null_resource.input_validator]
}
