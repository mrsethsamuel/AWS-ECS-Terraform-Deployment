########################################################################################################################
## Application Load Balancer in public subnets with HTTP default listener that redirects traffic to HTTPS
########################################################################################################################

resource "aws_alb" "alb" {
  name            = "${var.namespace}-alb"
  security_groups = [aws_security_group.alb.id]
  subnets         = aws_subnet.public.*.id

  tags = {
    Scenario = var.scenario
  }
}

########################################################################################################################
## Default HTTPS listener that blocks all traffic without valid custom origin header
########################################################################################################################


resource "aws_alb_listener" "alb_default_listener_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.alb_certificate.arn
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Access denied"
      status_code  = "403"
    }
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_acm_certificate.alb_certificate]
}


########################################################################################################################
## Default HTTPS listener that blocks all traffic without valid custom origin header
########################################################################################################################

resource "aws_alb_listener_rule" "web_https_listener_rule_prod" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  condition {
    host_header {
      values = ["${var.domain_name}"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web_service_target_group_prod.arn
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_acm_certificate.alb_certificate]
}


resource "aws_alb_listener_rule" "web_https_listener_rule_dev" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn


  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web_service_target_group_dev.arn
  }

  condition {
    host_header {
      values = ["dev.${var.domain_name}"]
    }
  }


  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_acm_certificate.alb_certificate]
}



########################################################################################################################
## HTTPS Listener Rule to only allow traffic with a valid custom origin header coming from CloudFront
########################################################################################################################

resource "aws_alb_listener_rule" "admin_https_listener_rule_prod" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.admin_service_target_group_prod.arn
  }

  condition {
    host_header {
      values = ["${var.admin_subdomain}"]
    }
  }


  tags = {
    Scenario = var.scenario
  }
}


resource "aws_alb_listener_rule" "api_https_listener_rule_prod" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.api_service_target_group_prod.arn
  }

  condition {
    host_header {
      values = ["${var.api_subdomain}"]
    }
  }

  tags = {
    Scenario = var.scenario
  }
}


resource "aws_alb_listener_rule" "admin_https_listener_rule_dev" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.admin_service_target_group_dev.arn
  }

  condition {
    host_header {
      values = ["${var.admin_subdomain_dev}"]
    }
  }


  tags = {
    Scenario = var.scenario
  }
}


resource "aws_alb_listener_rule" "api_https_listener_rule_dev" {
  listener_arn = aws_alb_listener.alb_default_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.api_service_target_group_dev.arn
  }

  condition {
    host_header {
      values = ["${var.api_subdomain_dev}"]
    }
  }


  tags = {
    Scenario = var.scenario
  }
}

########################################################################################################################
## Target Group for our service
########################################################################################################################

resource "aws_alb_target_group" "admin_service_target_group_prod" {
  name                 = "${var.namespace}-AdminTargetGroup-prod"
  port                 = var.admin_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}

resource "aws_alb_target_group" "api_service_target_group_prod" {
  name                 = "${var.namespace}-APITargetGroup-prod"
  port                 = var.api_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}


resource "aws_alb_target_group" "api_worker_service_target_group_prod" {
  name                 = "${var.namespace}-apiWorkerTGroup-prod"
  port                 = var.api_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}


resource "aws_alb_target_group" "admin_service_target_group_dev" {
  name                 = "${var.namespace}-AdminTargetGroup-dev"
  port                 = var.admin_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}

resource "aws_alb_target_group" "api_service_target_group_dev" {
  name                 = "${var.namespace}-APITargetGroup-dev"
  port                 = var.api_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}

resource "aws_alb_target_group" "api_worker_service_target_group_dev" {
  name                 = "${var.namespace}-apiWorkerTargetGroup-dev"
  port                 = var.api_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}


resource "aws_alb_target_group" "web_service_target_group_prod" {
  name                 = "${var.namespace}-WebTargetGroup-prod"
  port                 = var.web_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}

resource "aws_alb_target_group" "web_service_target_group_dev" {
  name                 = "${var.namespace}-WebTargetGroup-dev"
  port                 = var.web_container_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.default.id
  deregistration_delay = 5
  target_type          = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 60
    matcher             = var.healthcheck_matcher
    path                = var.healthcheck_endpoint
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 30
  }

  tags = {
    Scenario = var.scenario
  }

  depends_on = [aws_alb.alb]
}