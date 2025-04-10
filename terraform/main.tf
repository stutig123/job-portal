provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_key_pair" "jobportal_key" {
  key_name   = "stuti-jobportal-key"
  public_key = file("${path.module}/stuti-jobportal-key.pub")
}

resource "aws_instance" "jobportal_instance" {
  ami                         = "ami-03f4878755434977f" # Ubuntu 22.04 LTS in ap-south-1
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.jobportal_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "JobPortalApp"
  }

  provisioner "file" {
    source      = "stuti-jobportal-key.pem"
    destination = "/home/ubuntu/stuti-jobportal-key.pem"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("stuti-jobportal-key.pem")
    host        = self.public_ip
  }
}

output "public_ip" {
  value = aws_instance.jobportal_instance.public_ip
}
