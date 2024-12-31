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

resource "aws_instance" "my_server"{
    ami           = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"

  tags = {
    Name = "SampleExample"
  }
}
