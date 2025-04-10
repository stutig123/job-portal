provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "job_portal_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Choose an appropriate AMI ID
  instance_type = "t2.micro"
  key_name      = "stuti-jobportal-key"  # Ensure the key pair is created
  tags = {
    Name = "JobPortalInstance"
  }
}


