output "aws_secuirty_group" {
  value = aws_security_group.my_first_security_group
}

output "aws_instance" {
  value = values(aws_instance.http_instance).*.id
}

output "elb" {
  value = (aws_elb.elb)
}
