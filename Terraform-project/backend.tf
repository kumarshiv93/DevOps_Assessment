terraform {
  backend "s3" {
    bucket         = "shopyyy-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "shopyyy-terraform-lock"
    encrypt        = true
  }
