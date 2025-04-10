output "public_ip" {
  value = aws_instance.jobportal_instance.public_ip
}

output "private_key_pem" {
  value     = tls_private_key.jobportal_key.private_key_pem
  sensitive = true
}
