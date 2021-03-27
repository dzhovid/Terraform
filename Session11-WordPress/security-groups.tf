locals{
    rds_cidr_blocks = [var.cidr_block_private_subnet1,var.cidr_block_private_subnet2]
    ec2_cidr_blocks = [var.cidr_block_public_subnet]
#    rds_cidr_blocks = ["0.0.0.0/16"]
#    ec2_cidr_blocks = ["0.0.0.0/16"]
}
resource "aws_security_group" "ec2" {
  name = var.security_group_ec2
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    description = "MySQL"
    cidr_blocks = local.rds_cidr_blocks
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Telnet"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = [aws_vpc.my_vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  name = var.security_group_db

  description = "RDS (terraform-managed)"
  vpc_id      = aws_vpc.my_vpc.id

  # Only MySQL in
  ingress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups =  [aws_security_group.ec2.id]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.rds_cidr_blocks 
  }
}