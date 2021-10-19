resource "aws_spot_instance_request" "cheap_worker" {
  count                     = local.LENGTH
  ami                       = "ami-0e4e4b2f188e91845"
  spot_price                = "0.0035"
  instance_type             = "t2.micro"
  vpc_security_group_ids    = ["sg-0ce90bc6ff22f0a2c"]
  wait_for_fulfillment      = true
  //spot_type                 = "persistent"
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
//
//resource "aws_route53_record" "records" {
//  count                     = local.LENGTH
//  name                      = element(var.COMPONENTS, count.index)
//  type                      = "A"
//  zone_id                   = "Z00458692YJCZCCSC0W6X"
//  ttl                       = 300
//  records                   = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
//}
//
//resource "null_resource" "run-shell-scripting" {
//  depends_on                = [aws_route53_record.records]
//  count                     = local.LENGTH
//  provisioner "remote-exec" {
//    connection {
//      host                  = element(aws_spot_instance_request.cheap_worker.*.public_ip, count.index)
//      user                  = "centos"
//      password              = "DevOps321"
//    }
//
//    inline = [
//      "cd /home/centos",
//      "git clone https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps57/_git/shell-scripting",
//      "cd shell-scripting/roboshop",
//      "git pull",
//      "sudo make ${element(var.COMPONENTS, count.index)}"
//    ]
//  }
//}
//
locals {
  LENGTH    = length(var.COMPONENTS)
}