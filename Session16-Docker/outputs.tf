output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}
output "arn" {
  value = aws_instance.web.arn
}