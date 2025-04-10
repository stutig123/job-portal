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
  region     = "ap-south-1"  # Mumbai region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "job_portal_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS AMI in Mumbai (ap-south-1)
  instance_type = "t2.micro"  # Free tier eligible
  key_name      = "stuti-jobportal-key"  # Ensure the key pair is created
  tags = {
    Name = "JobPortalInstance"
  }
}

output "public_ip" {
  value = aws_instance.job_portal_instance.public_ip
}

