variable "ec2_sg_name" {}
variable "ec2_jenkins_sg" {}
variable "vpc_id" {}


output "ec2_sg_ssh_http" {
value = aws_security_group.ec2_sg.id

}

output "ec2_sg_jenkins" {
value = aws_security_group.sg_allow_jenkins.id
}




resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Allow SSH, HTTP and HTTPs from outside"
  vpc_id      = var.vpc_id


# allow SSH
ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
# Allow http
ingress {
    description = "Allow HHTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # allow https
  ingress {
    description = "Allow HTTPs from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags= {
    Name = "dev_proj_ec2_sg_ssh_http"
}
}

resource "aws_security_group" "sg_allow_jenkins"{
    vpc_id= var.vpc_id
    name= var.ec2_jenkins_sg
    description = "Allow port 8080 for Jenkins"

    ingress {
    description = "Allow 8080 for Jenkins from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "Allow port 8080 to access Jenkins on EC2"
  }
}


