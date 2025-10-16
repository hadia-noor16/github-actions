variable "alb_name" {}
variable "lb_type" {}
variable "is_external" {}
variable "sg_enable_ssh_http" {}
variable "public_subnet_ids" {}
variable "tag_name" {}
variable "tg_for_lb" {}
variable "ec2_instance_id" {}
variable "lb_http_listener_port" {}
variable "lb_http_listener_protocol" {}
variable "lb_listener_default_action" {}
variable "lb_listener_https_port" {}
variable "lb_listener_https_protocol" {}
variable "dev_proj_1_acm_arn" {}
variable "tg_attachment_port" {}

output "aws_alb_dns_name" {
  value= aws_lb.dev_proj_1_alb.dns_name
}

output "aws_lb_zone_id" {
  value = aws_lb.dev_proj_1_alb.zone_id
}


resource "aws_lb" "dev_proj_1_alb" {
  name               = var.alb_name
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = [var.sg_enable_ssh_http]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name= var.tag_name
  }

}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  target_group_arn = var.tg_for_lb
  target_id = var.ec2_instance_id
  port = var.tg_attachment_port
}

#HTTP → redirect to HTTPS
resource "aws_lb_listener" "dev_proj_1_lb_http_listener" {
  load_balancer_arn = aws_lb.dev_proj_1_alb.arn
  port = var.lb_http_listener_port
  protocol = var.lb_http_listener_protocol

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

}
}

resource "aws_lb_listener" "dev_proj_1_lb_https_listener" {
  load_balancer_arn = aws_lb.dev_proj_1_alb.arn
  port = var.lb_listener_https_port
  protocol = var.lb_listener_https_protocol
  certificate_arn   = var.dev_proj_1_acm_arn

  default_action {
    type             = var.lb_listener_default_action
    target_group_arn = var.tg_for_lb
  }

}

