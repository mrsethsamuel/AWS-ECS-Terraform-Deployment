########################################################################################################################
## Creates Admin ECS Service Prod
########################################################################################################################

resource "aws_ecs_service" "admin-prod" {
  name                               = "${var.namespace}-admin-prod"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.admin-prod.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.admin_service_target_group_prod.arn
    container_name   = var.admin_service_name
    container_port   = var.admin_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.admin_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}

########################################################################################################################
## Creates Admin ECS Service Dev
########################################################################################################################

resource "aws_ecs_service" "admin-dev" {
  name                               = "${var.namespace}-admin-dev"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.admin-dev.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.admin_service_target_group_dev.arn
    container_name   = var.admin_service_name
    container_port   = var.admin_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.admin_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}




########################################################################################################################
## Creates API ECS Service Prod
########################################################################################################################

resource "aws_ecs_service" "api-prod" {
  name                               = "${var.namespace}-api-prod"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.api-prod.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.api_service_target_group_prod.arn
    container_name   = var.api_service_name
    container_port   = var.api_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.api_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API ECS Service Dev
########################################################################################################################

resource "aws_ecs_service" "api-dev" {
  name                               = "${var.namespace}-api-dev"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.api-dev.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.api_service_target_group_dev.arn
    container_name   = var.api_service_name
    container_port   = var.api_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.api_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API Worker ECS Service Prod
########################################################################################################################

resource "aws_ecs_service" "api-worker-prod" {
  name                               = "${var.namespace}-api-worker-prod"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.api-worker.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"


  network_configuration {
    security_groups  = [aws_security_group.ecs_container_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}



########################################################################################################################
## Creates API Worker ECS Service Dev
########################################################################################################################

resource "aws_ecs_service" "api-worker-dev" {
  name                               = "${var.namespace}-api-worker-dev"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.api-worker-dev.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"


  network_configuration {
    security_groups  = [aws_security_group.ecs_container_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}



########################################################################################################################
## Creates Web ECS Service Prod
########################################################################################################################

resource "aws_ecs_service" "web-prod" {
  name                               = "${var.namespace}-web-prod"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.web-prod.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.web_service_target_group_prod.arn
    container_name   = var.web_service_name
    container_port   = var.web_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.admin_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates Web ECS Service dev
########################################################################################################################

resource "aws_ecs_service" "web-dev" {
  name                               = "${var.namespace}-web-dev"
  cluster                            = aws_ecs_cluster.default.id
  task_definition                    = aws_ecs_task_definition.web-dev.arn
  desired_count                      = var.ecs_task_desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.web_service_target_group_prod.arn
    container_name   = var.web_service_name
    container_port   = var.web_container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.admin_ecs_instance.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  tags = {
    Scenario = var.scenario
  }
}