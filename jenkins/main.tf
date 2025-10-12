variable "instance_type" {}
variable "ec2_ami" {}
variable "subnet_id" {}
variable "user_data_install_jenkins" {}
variable "public_key" {}
variable "security_group" {}
variable "enable_public_ip_address" {}


output "ec2_jenkins_server" {
  value = aws_instance.jenkins.id
}


resource "aws_instance" "jenkins"{
    ami = var.ec2_ami
    instance_type = var.instance_type
    tags ={
        Name = "ec2_jenkins"
    }
    subnet_id= var.subnet_id
    vpc_security_group_ids= var.security_group
    associate_public_ip_address = var.enable_public_ip_address
    user_data= var.user_data_install_jenkins
    key_name= "aws_ec2_terraform"



metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

data "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = "aws_ec2_terraform"
  public_key = var.public_key
}