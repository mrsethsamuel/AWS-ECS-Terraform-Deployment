resource "aws_secretsmanager_secret" "example_api_secret_dev" {
  name        = "example_api_secret_dev12"
  description = "Secrets for example API Development"
}

resource "aws_secretsmanager_secret_version" "example_api_secret_version_dev" {
  secret_id     = aws_secretsmanager_secret.example_api_secret_dev.id
  secret_string = jsonencode(var.example_api_secrets_dev)
}


resource "aws_secretsmanager_secret" "example_api_secret_prod" {
  name        = "example_api_secret_prod12"
  description = "Secrets for example API Production"
}

resource "aws_secretsmanager_secret_version" "example_api_secret_version_prod" {
  secret_id     = aws_secretsmanager_secret.example_api_secret_prod.id
  secret_string = jsonencode(var.example_api_secrets_prod)
}

data "aws_secretsmanager_secret" "secrets-prod" {
  arn = aws_secretsmanager_secret.example_api_secret_prod.arn
}
data "aws_secretsmanager_secret" "secrets-dev" {
  arn = aws_secretsmanager_secret.example_api_secret_dev.arn
}

data "aws_secretsmanager_secret_version" "example_api_secret_version_dev" {
  secret_id = data.aws_secretsmanager_secret.secrets-dev.id
}

data "aws_secretsmanager_secret_version" "example_api_secret_version_prod" {
  secret_id = data.aws_secretsmanager_secret.secrets-prod.id
}