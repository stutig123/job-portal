provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "tls_private_key" "jobportal_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jobportal_keypair" {
  key_name   = "stuti-jobportal-key"
  public_key = tls_private_key.jobportal_key.public_key_openssh
}

resource "aws_security_group" "jobportal_sg" {
  name        = "jobportal_sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jobportal_instance" {
  ami                    = "ami-03bb6d83c60fc5f7c" # Ubuntu 22.04 in ap-south-1
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.jobportal_keypair.key_name
  vpc_security_group_ids = [aws_security_group.jobportal_sg.id]

  tags = {
    Name = "JobPortalEC2"
  }
}
