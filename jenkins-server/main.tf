# main.tf
provider "aws" {
  region = var.region
}

# Data source to get VPC by name
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main-vpc"]
  }
}

# Data source to get public subnet
data "aws_subnet" "public" {
  vpc_id = data.aws_vpc.main.id
  
  filter {
    name   = "tag:Name"
    values = ["public-subnet-1"]
  }
}

# Data source to get security group
data "aws_security_group" "jenkins" {
  vpc_id = data.aws_vpc.main.id
  
  filter {
    name   = "tag:Name"
    values = ["jenkins-sg"]
  }

  filter {
    name   = "group-name"
    values = ["jenkins-sg"]
  }
}

# Ubuntu AMI data source
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Jenkins EC2 Instance
resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = data.aws_subnet.public.id

  vpc_security_group_ids = [data.aws_security_group.jenkins.id]

  user_data = file("userdata.sh")

  root_block_device {
    volume_size = 30  # Recommended for Jenkins
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "jenkins-server"
  }
}
