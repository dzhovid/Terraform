variable cidr_block_vpc {
    type = string
    default = "10.1.0.0/16"
    description = "CIDR block for VPC"
}

variable instance_tenancy {
    type = string
    default = "default"
    description = "Tenancy option of instances launched into VPC"
}

variable key_name {
    type = string
    default = "my_laptop_key"
    description = "key name"
}

variable ssh_key_path {
    type = string
    default = "~/.ssh/id_rsa.pub"
    description = "SSH key to connect to EC2"
}

variable region {
    type = string
    default = "us-east-1"
    description = "Location of resources"
}

variable cidr_block_subnet {
    type = string
    default = "10.1.1.0/24"
    description = "CIDR block for subnet"
}

variable map_public_ip_on_launch {
    type = bool
    default = true
    description = "True for assignment of Public IPs when creating EC2 into subnet"
}

variable cidr_block_route_table {
    type = string
    default = "0.0.0.0/0"
    description = "CIDR block for route table allow internet connection to IG"
}

variable ami {
    type = string
    description = "ami validation"
    validation {
      condition = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
      error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
    }
}

variable instance_type {
    type = string
    
}

variable security_group_name {
    type = string
    
}

variable security_group_description {
    type = string
    
}

variable prefix {
    type = string
}