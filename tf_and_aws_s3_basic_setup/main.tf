##This is a very simple script to just create an S3 bucket
terraform {
  required_providers {
    aws={
    source  = "hashicorp/aws"
    version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


##Addtionally you can setup cors policys for this
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-2025"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}