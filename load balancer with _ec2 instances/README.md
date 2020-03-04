How to Install Terraform on Linux

Download the terraform with command:-

1. sudo wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip

unzip the zip with command 

2. sudo unzip terraform_0.12.21_linux_amd64.zip

run the command 

3. sudo mv terraform /usr/local/bin/

check the terraform version

4. terraform --version

How to create aws ec2 instance with the help of terraform

Required:
Terraform installed on you pc
Must have aws secret key and access key

Clone the repository from url:-

   git clone https://github.com/sadhaura/terraform.git  
  
   change the directory load balancer with _ec2 instances with below command
  
 1. cd load balancer with _ec2 instances

   Change aws access key and secret key detail of your aws account in var.tf

   Run the below command for terraform initialization.
   
2. terraform init

   it will download neccessary plugins for terraform and initialize the terraform

   Run the below command for terraform apply 
   
   it will ask a value put yes in value field
   
   only yes will be accepted

3. terraform apply

   It will create load balancer with ec2 instances.

   if you want to delete all resources then simply  
   
   Run the command
 
4. terraform destroy










