resource "aws_vpc" "mtc_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}


resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_assoc" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mtc_public_rt.id
}

resource "aws_security_group" "mtc_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    description = "TLS to VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_route.default_route.destination_cidr_block]
  }

  ingress {
    description = "HTTP to VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_route.default_route.destination_cidr_block]
  }

  ingress {
    description = "SSH to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_route.default_route.destination_cidr_block]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-sg_tag"
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "mtc_auth" {
  key_name   = "myKey" # Create "myKey" to AWS
  public_key = tls_private_key.pk.public_key_openssh
  # public_key = "${file("terraform-demo.pub")}"    # Use if you have your own key

  # Saving public and private key in your computer
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo '${tls_private_key.pk.private_key_pem}' > ~/.ssh/myKey.pem
        chmod 400 ~/.ssh/myKey.pem

        echo '${tls_private_key.pk.public_key_openssh}' > ~/.ssh/myKey.pub
        chmod 400 ~/.ssh/myKey.pub
    EOT
  }

  # deleting public and private key from your computer
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        chmod 777 ~/.ssh/myKey.pem
        rm ~/.ssh/myKey.pem

        chmod 777 ~/.ssh/myKey.pub
        rm ~/.ssh/myKey.pub
    EOT
  }
}

resource "aws_instance" "instance" {
  for_each = var.instances

  ami                    = lookup(var.ami, "CentOS7-us-west-2")
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  key_name               = aws_key_pair.mtc_auth.id

  # user_data = file("userdata.tpl")
  # I'll be testing, so, I'll recreate the instance every time i run terraform apply
  user_data                   = "echo ${timestamp()} &> /dev/null "
  user_data_replace_on_change = var.recreate_instances_after_apply

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  tags = {
    Name = "${each.key}"
    # Name = "${var.instance_tags}-${count.index + 1}"
  }
}


# resource "aws_instance" "dev_node" {
#   count = var.instance_count


#   #using datasources
#   # ami                    = data.aws_ami.server_ami.id
#   # using map created by me
#   # ami                    = lookup(var.ami, var.aws_region)

#   ami                    = lookup(var.ami, "CentOS7-us-west-2")
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.mtc_sg.id]
#   subnet_id              = aws_subnet.mtc_public_subnet.id
#   key_name               = aws_key_pair.mtc_auth.id

#   # user_data = file("userdata.tpl")
#   # I'll be testing, so, I'll recreate the instance every time i run terraform apply
#   user_data                   = "echo ${timestamp()} &> /dev/null "
#   user_data_replace_on_change = true

#   root_block_device {
#     volume_size = 8
#     volume_type = "standard"
#   }

#   tags = {
#     Name = "${var.instance_tags}-${count.index + 1}"
#   }
# }
