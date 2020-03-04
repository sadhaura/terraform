Terraform will automatically search for saved API credentials in ~/.aws/credentials or IAM instance profile credentials:


~/.aws/credentials
[default]
aws_access_key_id = B...T
aws_secret_access_key = 8...Z


In our example, the resource type is "aws_instance" and the resource name is "terra-sample0.


provider "aws"  {
	shared_credentials_file = "/home/k/.aws/credentials"
  	profile                 = "terraform"
}
resource "aws_instance" "terra-sample0"  {
  	ami 			= "ami-04169656fea786776"
  	instance_type	= "t2.nano"
}




Assigning an Elastic IP



provider "aws" {
  region     = "us-east-1"
  profile    = "terraform"
}

resource "aws_instance" "terra-sample0" {
  ami           = "ami-00395b56cb6891346"
  instance_type = "t2.nano"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.terra-sample0.id}"
}




Add Elastic IP to ec2 instances


resource "aws_eip" "ip" {
  instance   = "${aws_instance.terra-sample0.id}"
  depends_on = ["aws_instance.terra-sample0"]
}


Create Two ec2 instances one with elastic ip


provider "aws" {
  region     = "us-east-1"
  profile    = "terraform"
}

resource "aws_instance" "terra-sample0" {
  ami           = "ami-00395b56cb6891346"
  instance_type = "t2.nano"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.terra-sample0.id}"
}

resource "aws_instance" "another" {
  ami           = "ami-04169656fea786776"
  instance_type = "t2.nano"
}



Provisioner

Provisioning is important for being able to bootstrap instances.


If we need to do some initial setup on our instances, then provisioners let us upload files, run shell scripts, or install and trigger other software like configuration management tools, etc.

To define a provisioner, modify the resource block defining the "terra-sample0" EC2 instance to look like the following:


provider "aws" {
  region     = "us-east-1"
  profile    = "terraform"
}

resource "aws_instance" "terra-sample1" {
  ami           = "ami-00395b56cb6891346"
  instance_type = "t2.nano"

  provisioner "local-exec" {
    command = "echo ${aws_instance.terra-sample1.public_ip} > ip_address.txt"
  }
}



Defining Variables
Let's first extract our access key, secret key, and region into a few variables. Create another file variables.tf:



variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}


The first two have empty blocks {}. The third sets a default. If a default value is set, the variable is optional. Otherwise, the variable is required. If we run terraform plan now, Terraform will prompt us for the values for unset string variables:


myresource.tf

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}`



Output variables


We can use output variables as a way to organize data to be easily queried and shown back to the Terraform user.

When building potentially complex infrastructure, Terraform stores hundreds or thousands of attribute values for all our resources. But as a user of Terraform, we may only be interested in a few values of importance, such as a load balancer IP, VPN address, etc.



provider "aws" {
  region     = "us-east-1"
  profile    = "terraform"
}

resource "aws_instance" "terra-sample0" {
  ami           = "ami-00395b56cb6891346"
  instance_type = "t2.nano"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.terra-sample0.id}"
}

resource "aws_instance" "another" {
  ami           = "ami-04169656fea786776"
  instance_type = "t2.nano"
}


output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

for example the result will be


$ terraform apply
...
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

  ip = 50.17.232.209


$ terraform output ip
50.17.232.209




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

