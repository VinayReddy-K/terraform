resource "aws_instance" "sample" {
  ami                    = "ami-0e4e4b2f188e91845"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.SG_ID]

  tags                   = {
    Name = "sample"
  }
}

variable "SG_ID" {}

output "PRIVATE_IP" {
  value = aws_instance.sample.private_ip
}