resource "aws_spot_instance_request" "cheap_worker" {
  count                     = local.LENGTH
  ami                       = "ami-077fb3e62ddf0fa9a"
  spot_price                = "0.0035"
  instance_type             = "t2.micro"
  availability_zone         = "us-east-1a"
  vpc_security_group_ids    = ["sg-0ce90bc6ff22f0a2c"]
  wait_for_fulfillment      = true
  //spot_type               = "persistent"
  tags                      = {
    Name                    = element(var.COMPONENTS, count.index)
  }
}

resource "aws_ec2_tag" "name-tag" {
  count                     = local.LENGTH
  resource_id               = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
  key                       = "Name"
  value                     = element(var.COMPONENTS, count.index)
}

resource "aws_route53_record" "records" {
  count                     = local.LENGTH
  name                      = element(var.COMPONENTS, count.index)
  type                      = "A"
  zone_id                   = "Z05588222UV008VFLU0F0"
  ttl                       = 300
  records                   = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
}

resource "null_resource" "run-shell-scripting" {
  depends_on                = [aws_route53_record.records]
  count                     = local.LENGTH
  provisioner "remote-exec" {
    connection {
      host                  = element(aws_spot_instance_request.cheap_worker.*.public_ip, count.index)
      user                  = "centos"
      password              = "DevOps321"
    }

    inline = [
      "cd /home/centos",
      "git clone https://github.com/VinayReddy-K/shell-scripting.git",
      "cd shell-scripting/roboshop",
      "git pull",
      "sudo make ${element(var.COMPONENTS, count.index)}"
    ]
  }
}

locals {
  LENGTH    = length(var.COMPONENTS)
}

output "attributes" {
  value = aws_spot_instance_request.cheap_worker.*.spot_instance_id
}