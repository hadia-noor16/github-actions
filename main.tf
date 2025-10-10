module "networking"{
    source= "./networking"
    vpc_cidr= var.vpc_cidr
    vpc_name = var.vpc_name
    availability_zone = var.availability_zone
    cidr_public_subnet= var.cidr_public_subnet
    cidr_private_subnet = var.cidr_private_subnet

}

module "security_group" {
    source = "./security_group"
    vpc_id= module.networking.dev_proj_1_vpc_id
    ec2_sg_name = "Allow http, https, SSH"
    ec2_jenkins_sg= "Allow port 8080 for Jenkins"
} 
   

module "jenkins" {
    source = "./jenkins"
    instance_type= "t2.medium"
    ec2_ami= var.ec2_ami
    security_group=[module.security_group.ec2_sg_ssh_http,
    module.security_group.ec2_sg_jenkins]
    public_key = var.public_key
    subnet_id = module.networking.public_subnet_ids[0]
    enable_public_ip_address= true
    user_data_install_jenkins= templatefile ("./jenkins_user_data/user_data.sh", {})
}

