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
  key_name   = "myKey"   # Create "myKey" to AWS
  public_key = tls_private_key.pk.public_key_openssh
  # public_key = "${file("terraform-demo.pub")}"    # Use if you have your own key

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ~/.ssh/myKey.pem\nchmod 400 ~/.ssh/myKey.pem"
  }
}

resource "aws_instance" "dev_node" {
  count = var.instance_count
  
  #using datasources
  #ami                    = data.aws_ami.server_ami.id
  ami                    = lookup(var.ami,var.aws_region)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  key_name               = aws_key_pair.mtc_auth.id

  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }

  tags = {
    Name = "${var.instance_tags}-${count.index + 1}"
  }

  # PROVISIONER => used to configure ./ssh/config when creating the ec2 instance using template windows-ssh-config.tpl
  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_dns,             # hostname of the ec2 instance
      user         = "ubuntu",                    # default is "root"
      identityfile = pathexpand("~/.ssh/myKey.pem") # path to the private key
    })

    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "-Command"] # default is ["powershell", "-Command"]
  }

}