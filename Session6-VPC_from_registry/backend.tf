terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/session6-vpc-module.tfstate"
    region = "us-east-1"
  }
}