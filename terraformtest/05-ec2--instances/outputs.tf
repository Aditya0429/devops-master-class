output "aws_secuirty_group" {
  value = aws_security_group.my_first_security_group
}

output "aws_instance" {
  value = aws_instance.http_instance.public_dns
}

