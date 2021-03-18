resource "aws_security_group" "sg_1" {
  name        = var.security_group_name
  description = var.security_group_description
  
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    #from_port   = 8080  #uncomment when installing Jenkins
    to_port     = 22
    #to_port   = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix} allow_ssh_http"
  }
}