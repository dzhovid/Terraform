output "endpoint" {
    value = aws_db_instance.db.address
}
output "ip_address" {
    value = aws_instance.web.public_ip
}
output "db_access_from_ec2" {
  value = "mysql -h ${aws_db_instance.db.address} -P ${aws_db_instance.db.port} -u ${var.username} -p${var.password}"
}
output "access" {
  value = "http://${aws_instance.web.public_ip}/index.php"
}