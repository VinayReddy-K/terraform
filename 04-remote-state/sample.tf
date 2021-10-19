resource "aws_instance" "sample" {
  ami                    = "ami-0e4e4b2f188e91845"
  instance_type          = "t2.micro"
  tags                   = {
    Name = "sample"
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-s03"
    key    = "sample/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}