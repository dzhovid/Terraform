terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/terraform-data-source.tfstate"
    region = "us-east-1"
  }
}