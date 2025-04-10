provider "aws" {
  region = "ap-south-1"
}

# Use existing key pair
data "aws_key_pair" "existing" {
  key_name = "stuti-key"
}

# Create EC2 instance
resource "aws_instance" "jobportal" {
  ami                         = "ami-03bb6d83c60fc5f7c"
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.existing.key_name
  associate_public_ip_address = true

  tags = {
    Name = "job-portal-instance"
  }
}

# Output public IP
output "public_ip" {
  value = aws_instance.jobportal.public_ip
}
