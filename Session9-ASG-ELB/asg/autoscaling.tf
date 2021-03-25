resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = var.name_prefix
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = var.instance_type
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id]
  user_data = <<-EOF
                 #!/bin/bash
                  sudo apt-get update
                  sudo apt-get install apache2 -y
                  sudo systemctl enable apache2
                  sudo systemctl start apache2
              EOF
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = var.name
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

