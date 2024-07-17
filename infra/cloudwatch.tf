########################################################################################################################
## Create log group for our service
########################################################################################################################

resource "aws_cloudwatch_log_group" "api_log_group" {
  name              = "/${lower(var.namespace)}/ecs/${var.api_service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Scenario = var.scenario
  }
}


resource "aws_cloudwatch_log_group" "admin_log_group" {
  name              = "/${lower(var.namespace)}/ecs/${var.admin_service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Scenario = var.scenario
  }
}

resource "aws_cloudwatch_log_group" "api_worker_log_group" {
  name              = "/${lower(var.namespace)}/ecs/${var.api_worker_service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Scenario = var.scenario
  }
}


resource "aws_cloudwatch_log_group" "web_log_group" {
  name              = "/${lower(var.namespace)}/ecs/${var.web_service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Scenario = var.scenario
  }
}