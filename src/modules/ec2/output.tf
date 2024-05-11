output "ec2_public_ip" {
  description = "IP publica de la instancia"
  value       = aws_instance.xcoin.public_ip
}

output "EIP" {
  value = aws_eip.mongodb_eip.public_ip
}
