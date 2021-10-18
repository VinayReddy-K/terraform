//esource "aws_instance" "sample" {
// ami           = ami-0e4e4b2f188e91845
// instance_type = "t2.micro"
// tags          = {
//   Name        = "sample"
// }
//

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow_ssh"

  ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "allow_ssh"
  }
}

output "sg_id" {
  value = aws_security_group.allow_ssh
}

provider "aws" {
  region = "us-east-1"
}