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
    security_group=[module.security_group.ec2_sg_ssh_http, module.security_group.ec2_sg_jenkins]
    demokey                    = var.demokey
    subnet_id = module.networking.public_subnet_ids[0]
    enable_public_ip_address= true
    user_data_install_jenkins= templatefile ("./jenkins_user_data/user_data.sh", {})
}

module "lb_target_group" {
    source = "./lb_target_group"
    lb_target_group_name = "Target-group-for-jenkins-server"
    lb_target_group_port = 8080
    lb_target_group_protocol = "HTTP"
    vpc_id= module.networking.dev_proj_1_vpc_id
    ec2_instance_id= module.jenkins.ec2_jenkins_server
}

module "alb" {
    source = "./alb"
    alb_name = "dev-proj-1-alb"
    lb_type = "application"
    is_external = false
    sg_enable_ssh_http = module.security_group.ec2_sg_ssh_http
    public_subnet_ids= module.networking.public_subnet_ids
    tag_name = "ALB for Jenkins"
    tg_for_lb= module.lb_target_group.tg_arn
    ec2_instance_id = module.jenkins.ec2_jenkins_server
    lb_http_listener_port = 80
    lb_http_listener_protocol = "HTTP"
    lb_listener_default_action= "forward"
    lb_listener_https_port = 443
    lb_listener_https_protocol = "HTTPS"
    dev_proj_1_acm_arn = module.ssl_certificate.dev_proj_1_acm_arn
    tg_attachment_port = 80
}

module "hosted_zone" {
    source = "./hosted_zone"
    domain_name = "mydevopslife.com"
    aws_alb_dns=module.alb.aws_alb_dns_name
    hosted_zone_id= module.hosted_zone.hosted_zone_id
}

module "ssl_certificate" {
    source = "./ssl_certificate"
    domain_name= "mydevopslife.com"
    hosted_zone_id=module.hosted_zone.hosted_zone_id
}