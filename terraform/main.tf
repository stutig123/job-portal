provider "aws" {
  region = "ap-south-1"
}

resource "tls_private_key" "jobportal_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jobportal_key" {
  key_name   = "jobportal-key"
  public_key = tls_private_key.jobportal_key.public_key_openssh
}

resource "aws_instance" "jobportal" {
  ami           = "ami-0a7cf821b91bcccbc" # Ubuntu 22.04 LTS in ap-south-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jobportal_key.key_name

  tags = {
    Name = "JobPortalEC2"
  }

  provisioner "local-exec" {
    command = "echo '${tls_private_key.jobportal_key.private_key_pem}' > stuti-jobportal-key.pem && chmod 400 stuti-jobportal-key.pem"
  }

  security_groups = [aws_security_group.jobportal_sg.name]
}

resource "aws_security_group" "jobportal_sg" {
  name        = "jobportal-sg"
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

output "public_ip" {
  value = aws_instance.jobportal.public_ip
}
