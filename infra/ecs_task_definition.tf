
########################################################################################################################
## Creates Admin ECS Task Definition Prod
########################################################################################################################

resource "aws_ecs_task_definition" "admin-prod" {
  family                   = "${var.namespace}-AdminTaskDefinition-prod"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.admin_service_name #"${var.namespace}-admin-${var.environment}"
      image     = var.sample_image       #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.admin_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.admin_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.admin_service_name}-log-stream-prod"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API ECS Task Definition
########################################################################################################################

resource "aws_ecs_task_definition" "api-prod" {
  family                   = "${var.namespace}-APITaskDefinition-prod"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.api_service_name
      image     = var.sample_image
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.api_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.api_service_name}-log-stream-prod"
        }
      }
     secrets = [
        {
          "name" : "API_BASE_URL",
          "valueFrom" : "${data.aws_secretsmanager_secret_version.example_api_secret_version_prod.arn}:API_BASE_URL::"
        },
        {
          "name" : "JWT_AUDIENCE",
          "valueFrom" : "${data.aws_secretsmanager_secret_version.example_api_secret_version_prod.arn}:JWT_AUDIENCE::"
        }]


    }
  ])

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API Worker ECS Task Definition
########################################################################################################################

resource "aws_ecs_task_definition" "api-worker" {
  family                   = "${var.namespace}-APIWorkerTaskDefinition-prod"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = "${var.namespace}-api-worker-prod"
      image     = var.sample_image #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api_worker_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.api_worker_service_name}-log-stream-prod"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}





########################################################################################################################
## Creates Admin ECS Task Definition Dev 
########################################################################################################################

resource "aws_ecs_task_definition" "admin-dev" {
  family                   = "${var.namespace}-AdminTaskDefinition-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.admin_service_name #"${var.namespace}-admin-${var.environment}"
      image     = var.sample_image       #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.admin_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.admin_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.admin_service_name}-log-stream-dev"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API ECS Task Definition Dev
########################################################################################################################

resource "aws_ecs_task_definition" "api-dev" {
  family                   = "${var.namespace}-APITaskDefinition-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.api_service_name #"${var.namespace}-api-${var.environment}"
      image     = var.sample_image     #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.api_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.api_service_name}-log-stream-dev"
        }
      }
     secrets = [
        {
          "name" : "API_BASE_URL",
          "valueFrom" : "${data.aws_secretsmanager_secret_version.example_api_secret_version_dev.arn}:API_BASE_URL::"
        },
        {
          "name" : "JWT_AUDIENCE",
          "valueFrom" : "${data.aws_secretsmanager_secret_version.example_api_secret_version_dev.arn}:JWT_AUDIENCE::"
        }]

    }
  ])

  tags = {
    Scenario = var.scenario
  }
}


########################################################################################################################
## Creates API Worker ECS Task Definition Dev
########################################################################################################################

resource "aws_ecs_task_definition" "api-worker-dev" {
  family                   = "${var.namespace}-APIWorkerTaskDefinition-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = "${var.namespace}-api-worker-dev"
      image     = var.sample_image #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api_worker_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.api_worker_service_name}-log-stream-dev"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}




########################################################################################################################
## Creates Web ECS Task Definition Prod
########################################################################################################################

resource "aws_ecs_task_definition" "web-prod" {
  family                   = "${var.namespace}-WebTaskDefinition-prod"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.web_service_name #"${var.namespace}-admin-${var.environment}"
      image     = var.sample_image     #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.web_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.web_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.web_service_name}-log-stream-prod"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}



########################################################################################################################
## Creates Web ECS Task Definition Dev
########################################################################################################################

resource "aws_ecs_task_definition" "web-dev" {
  family                   = "${var.namespace}-WebTaskDefinition-dev"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.cpu_units
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.web_service_name #"${var.namespace}-admin-${var.environment}"
      image     = var.sample_image     #"${aws_ecr_repository.ecr.repository_url}:${var.hash}"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.web_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.web_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${var.web_service_name}-log-stream-dev"
        }
      }
    }
  ])

  tags = {
    Scenario = var.scenario
  }
}


