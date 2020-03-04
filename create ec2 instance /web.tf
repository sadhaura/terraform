provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = "${var.aws_region}"
}

resource "aws_instance" "web_server" {
ami = "ami-021bb9f371690f97a"
instance_type = "t2.micro"
tags = {
    Name = "testTag"
  }
}
