variable "domain_name" {}
variable "aws_alb_dns" {}
variable "hosted_zone_id" {}
variable "alb_zone_id" {}


output "hosted_zone_id" {
    value= data.aws_route53_zone.dev_proj_1_mydevopslife.zone_id
}


data "aws_route53_zone" "dev_proj_1_mydevopslife" {
    name = var.domain_name
    private_zone= false

}

resource "aws_route53_record" "a_alias" {
  zone_id = data.aws_route53_zone.dev_proj_1_mydevopslife.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.aws_alb_dns
    zone_id                = var.alb_zone_id   
    evaluate_target_health = false
  }
}

