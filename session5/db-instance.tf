resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = var.subnetgroup
  subnet_ids = [aws_subnet.private_subnet1.id,aws_subnet.private_subnet2.id ]
}

resource "aws_db_instance" "_" {
  
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.id
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  name                    = var.name
  username                = var.username
  # password              = random_password.password.result
  password                = var.password
  port                    = var.port
  publicly_accessible     = var.publicly_accessible
  storage_encrypted       = var.storage_encrypted
  storage_type            = var.storage_type
  skip_final_snapshot       = true

  vpc_security_group_ids = [aws_security_group.db.id]

}