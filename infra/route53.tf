########################################################################################################################
## Create Route53 Hosted Zone for the domain of the service including NS records in the top level domain.
## For this scenario, we assume that the service is running on a subdomain, like service.example.com.
########################################################################################################################

data "aws_route53_zone" "main_zone" {
  name = var.domain_name
}

########################################################################################################################
## Point "CNAME" record to Loadbalancer
########################################################################################################################

resource "aws_route53_record" "api_service_record_prod" {
  name    = var.api_subdomain
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "admin_service_record_prod" {
  name    = var.admin_subdomain
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "api_service_record_dev" {
  name    = var.api_subdomain_dev
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "admin_service_record_dev" {
  name    = var.admin_subdomain_dev
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "web_service_record_dev" {
  name    = "dev.${var.domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "web_service_record_prod" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.main_zone.zone_id

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = false
  }
}