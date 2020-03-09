provider "aws" {
  region = "${var.region}"

}

variable "env" {
default = "prod"
}

resource "aws_vpc" "myapp_vpc" {
  count = "${var.env == "prod" ? 1 :0}"
  cide_block   = "10.2.0.0/16"
  instance_tenancy = "default"

  tags {

  Name = "myapp_vpc"
  AppName = "MyApp"
}
}
