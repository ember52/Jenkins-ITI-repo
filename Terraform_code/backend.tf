terraform {
  backend "s3" {
    bucket = "hassan-bucket-test"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}

