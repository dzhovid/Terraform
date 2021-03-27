# resource "random_password" "password" {
#   length           = 16
#   special          = true
#   override_special = "_%@"
# }

resource "aws_db_subnet_group" "db_subnet" {
  name       = var.subnetgroup
  subnet_ids = [aws_subnet.private_subnet1.id,aws_subnet.private_subnet2.id ]
}

resource "aws_db_instance" "db" {
  
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.id
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  name                    = var.name
  username                = var.username
  password                = var.password
  port                    = var.port
  storage_encrypted       = var.storage_encrypted
  storage_type            = var.storage_type
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot     = true

  vpc_security_group_ids = [aws_security_group.db.id]

}