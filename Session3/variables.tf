variable "subnet_id" {}

variable "vpc_id" {}

variable "instance_tenancy" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "region" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "prefix" {
  type = string
}

variable "ami" {
  type = map(any)
  default = {
    "us-east-1" = "ami-038f1ca1bd58a5790"
    "us-east-2" = "ami-07a0844029df33d7d"
    "us-west-1" = "ami-0c7945b4c95c0481c"
  }
}
variable "instance_type" {
  type = string
}

# variable "domain" {}
# variable "record" {}