output "ec2_public_ip" {
  description = "IP publica de la instancia"
  value       = aws_instance.backend.public_ip
}

output "db_host" {
  #value = aws_db_instance.default.endpoint
  value = aws_db_instance.XCoin_DB.endpoint
}