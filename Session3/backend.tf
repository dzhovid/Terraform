terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/data-source3.tfstate"
    region = "us-east-1"
  }
}