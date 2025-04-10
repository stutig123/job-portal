# Provider Configuration
provider "aws" {
  region     = "ap-south-1"  # Specify the Mumbai region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# EC2 Instance Resource
resource "aws_instance" "job_portal_instance" {
  ami               = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID in ap-south-1
  instance_type     = "t2.micro"  # Instance type, adjust as needed
  key_name          = "stuti-jobportal-key"  # Ensure this key pair is already created in AWS
  availability_zone = "ap-south-1b"  # Specify availability zone 'ap-south-1b'
  tags = {
    Name = "JobPortalInstance"
  }
}

# Output: Public IP of the EC2 instance
output "public_ip" {
  value = aws_instance.job_portal_instance.public_ip
}
