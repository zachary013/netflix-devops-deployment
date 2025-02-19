# main.tf
provider "aws" {
  region = var.region
}

# Data source to get VPC by name
data "aws_vpc" "main" {
  tags = {
    Name = "main-vpc"
  }
}

# Data source to get public subnet
data "aws_subnet" "public" {
  tags = {
    Name = "public-subnet-1"  # Make sure this matches your subnet tag
  }
  vpc_id = data.aws_vpc.main.id
}

# Data source to get security group
data "aws_security_group" "jenkins" {
  tags = {
    Name = "jenkins-sg"
  }
  vpc_id = data.aws_vpc.main.id
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

  tags = {
    Name = "jenkins-server"
  }
}
