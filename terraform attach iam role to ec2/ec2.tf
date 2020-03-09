provider "aws" {
region = "us-east-1"
}


resource "aws_instance" "web" {
  ami           = "ami-0e2ff28bfb72a4e45"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  tags = {
    Name = "HelloWorld"
  }
}
