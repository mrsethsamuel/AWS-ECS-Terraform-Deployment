########################################################################################################################
## Container registry for the service's Docker image
########################################################################################################################

resource "aws_ecr_repository" "ecr-api" {
  name         = "example-api"
  force_delete = var.ecr_force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Scenario = var.scenario
  }
}


resource "aws_ecr_repository" "ecr-admin" {
  name         = "example-admin"
  force_delete = var.ecr_force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Scenario = var.scenario
  }
}


resource "aws_ecr_repository" "ecr-api-worker" {
  name         = "example-api-worker"
  force_delete = var.ecr_force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Scenario = var.scenario
  }
}

resource "aws_ecr_repository" "ecr-web" {
  name         = "example-web"
  force_delete = var.ecr_force_delete

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Scenario = var.scenario
  }
}