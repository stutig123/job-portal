# Declare AWS credentials as variables
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  default     = ""  # Empty default so it must be passed
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  default     = ""  # Empty default so it must be passed
}

# AWS provider configuration
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# EC2 instance resource
resource "aws_instance" "job_portal_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Choose an appropriate AMI ID
  instance_type = "t2.micro"
  key_name      = "stuti-jobportal-key"  # Ensure the key pair is created
  tags = {
    Name = "JobPortalInstance"
  }
}

# Output the public IP of the EC2 instance
output "public_ip" {
  value = aws_instance.job_portal_instance.public_ip
}
