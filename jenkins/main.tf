variable "instance_type" {}
variable "ec2_ami" {}
variable "subnet_id" {}
variable "user_data_install_jenkins" {}
variable "demokey" {}
variable "security_group" {}
variable "enable_public_ip_address" {}


output "ec2_jenkins_server" {
  value = aws_instance.jenkins.id
}

data "aws_key_pair" "jenkins_key" {
  key_name = var.demokey
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
    key_name= data.aws_key_pair.jenkins_key.key_name



metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

