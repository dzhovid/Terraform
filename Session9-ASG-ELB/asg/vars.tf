variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable name_prefix {}
variable instance_type {}
variable name {}
variable min_size {}
variable max_size {}
variable health_check_grace_period {}
variable health_check_type {}