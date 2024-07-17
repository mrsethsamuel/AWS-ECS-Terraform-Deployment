# terraform.tfvars

########################################################################################################################
## Service variables
########################################################################################################################

namespace               = "example"
domain_name             = "example.co"
api_service_name        = "example-api"
admin_service_name      = "example-admin"
web_service_name        = "example-web"
api_worker_service_name = "example-api-worker"
scenario                = "scenario-ecs-fargate"
environment             = "dev"
nameservers             = ["ns63.example.com", "ns64.example.com"]
hosted_zone_id          = "hosted_zone_id"
api_subdomain           = "api.example.co"
admin_subdomain         = "admin.example.co"
api_subdomain_dev       = "api.dev.example.co"
admin_subdomain_dev     = "admin.dev.example.co"

########################################################################################################################
## AWS credentials
########################################################################################################################

aws_access_key_id     = "aws_access_key_id"
aws_secret_access_key = "aws_secret_access_key"
region                = "eu-central-1"

########################################################################################################################
## Network variables
########################################################################################################################

tld_zone_id    = "tld_zone_id"
vpc_cidr_block = "10.2.0.0/16"
az_count       = 2

########################################################################################################################
## ECS variables
########################################################################################################################

ecs_task_desired_count                      = 2
ecs_task_min_count                          = 1
ecs_task_max_count                          = 5
ecs_task_deployment_minimum_healthy_percent = 50
ecs_task_deployment_maximum_percent         = 100
cpu_target_tracking_desired_value           = 75
memory_target_tracking_desired_value        = 80
target_capacity                             = 100
admin_container_port                        = 3000
api_container_port                          = 30040
cpu_units                                   = 256
memory                                      = 512

########################################################################################################################
## Cloudwatch
########################################################################################################################

retention_in_days = 7

########################################################################################################################
## ECR
########################################################################################################################

ecr_force_delete = true

########################################################################################################################
## ALB
########################################################################################################################

custom_origin_host_header = "exampleCloudFront"
healthcheck_endpoint      = "/"
healthcheck_matcher       = "200"


example_api_secrets_dev = {
  "API_BASE_URL" : "http://localhost",
  "JWT_AUDIENCE" : "http://localhost:4000",
  "DEFAULT_TIMEZONE" : "Africa/Lagos",
  "JWT_ISSUER" : "localhost",
  }
