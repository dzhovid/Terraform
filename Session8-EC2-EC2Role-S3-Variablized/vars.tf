variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}


variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "key_name" {
  default = "developer_key"
  
}

variable "bucket_role_name" {} 
variable "role_policy_name" {}  
variable "security_group_name" {} 
variable "instance_type" {}       
variable "bucket_name" {}