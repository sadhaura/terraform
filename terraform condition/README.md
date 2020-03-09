How to Install Terraform on Linux

Download the terraform with command:-

sudo wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip the zip with command

sudo unzip terraform_0.12.21_linux_amd64.zip
run the command

sudo mv terraform /usr/local/bin/
check the terraform version

terraform --version
How to create aws ec2 instance with the help of terraform

Required: Terraform installed on you pc Must have aws secret key and access key

Clone the repository from url:-

git clone https://github.com/sadhaura/terraform.git

change the directory terraform_condition with below command

cd terraform_condition

Change aws access key and secret key detail of your aws account in var.tf

Run the below command for terraform initialization.

terraform init

it will download neccessary plugins for terraform and initialize the terraform

Run the below command for terraform apply

it will ask a value put yes in value field

only yes will be accepted

terraform apply

It will create vpc.

if you want to delete the vpc mentioned in vpc.tf then simply

Run the command

terraform destroy

terraform condition :

In this example if the condition is true ie var.env == prod then the vpc will be created otherwise not 

it the count is 0 then no vpc is created 



