########################################################################################################################
## IAM Role for ECS Task execution
########################################################################################################################

data "aws_iam_policy_document" "task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.namespace}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json

  tags = {
    Scenario = var.scenario
  }
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "${var.namespace}-secrets-manager-policy"
  description = "Policy to allow access to AWS Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = "*" // Update this with the specific ARN of the secret if possible
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_secrets_manager_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

########################################################################################################################
## IAM Role for ECS Task
########################################################################################################################

resource "aws_iam_role" "ecs_task_iam_role" {
  name               = "${var.namespace}-ecs-task-iam-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json

  tags = {
    Scenario = var.scenario
  }
}