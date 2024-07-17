########################################################################################################################
## SG for ECS Container Instances
########################################################################################################################

resource "aws_security_group" "ecs_container_instance" {
  name        = "${var.namespace}-ECS-Task-SecurityGroup"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = aws_vpc.default.id

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}-ECS-Task-SecurityGroup"
    Scenario = var.scenario
  }
}


resource "aws_security_group" "admin_ecs_instance" {
  name        = "${var.namespace}-admin-service-securityGroup"
  description = "Security group for Admin ECS task running on Fargate"
  vpc_id      = aws_vpc.default.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP only"
    from_port       = var.admin_container_port
    to_port         = var.admin_container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}-admin-service-securityGroup"
    Scenario = var.scenario
  }
}


resource "aws_security_group" "api_ecs_instance" {
  name        = "${var.namespace}-api-service-securityGroup"
  description = "Security group for API ECS task running on Fargate"
  vpc_id      = aws_vpc.default.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP only"
    from_port       = var.api_container_port
    to_port         = var.api_container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}-api-service-securityGroup"
    Scenario = var.scenario
  }
}


########################################################################################################################
## SG for ALB
########################################################################################################################

resource "aws_security_group" "alb" {
  name        = "${var.namespace}-ALB-SecurityGroup"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "Allow all ingress traffic"
    from_port   = 443 # HTTPS port
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from all IP addresses
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.namespace}-ALB-SecurityGroup"
    Scenario = var.scenario
  }
}

########################################################################################################################
## We only allow incoming traffic on HTTPS from known CloudFront CIDR blocks
########################################################################################################################

# data "aws_ec2_managed_prefix_list" "cloudfront" {
#   name = "com.amazonaws.global.cloudfront.origin-facing"
# }

# resource "aws_security_group_rule" "alb_cloudfront_https_ingress_only" {
#   security_group_id = aws_security_group.alb.id
#   description       = "Allow HTTPS access only from CloudFront CIDR blocks"
#   from_port         = 443
#   protocol          = "tcp"
#   prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
#   to_port           = 443
#   type              = "ingress"
# }