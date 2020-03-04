Maps


AMIs are specific to the region that is in use. One option is to just ask the user to input the proper AMI for the region, but Terraform can do better than that with maps.


Maps are a way to create variables that are lookup tables. An example will show this best. Let's extract our AMIs into a map and add support for the us-west-2 region as well:


variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}


A variable can have a map type assigned explicitly, or it can be implicitly declared as a map by specifying a default value that is a map. The above demonstrates both.


Then, replace the aws_instance with the following:


resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}


This introduces a new type of interpolation: a function call. The lookup function does a dynamic lookup in a map for a key. The key is "var.region", which specifies that the value of the region variables is the key.


this will create a instance in specific region what we have mentioned.
