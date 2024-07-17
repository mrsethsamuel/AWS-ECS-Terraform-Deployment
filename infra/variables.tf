########################################################################################################################
## Service variables
########################################################################################################################

variable "namespace" {
  description = "Namespace for resource names"
  default     = "example"
  type        = string
}

variable "domain_name" {
  description = "Domain name of the service (like example.co)"
  type        = string
  default     = "example.co"
}

variable "api_subdomain" {
  description = "Subdomain name of the api service (like api.example.co)"
  type        = string
  default     = "api.example.co"
}

variable "admin_subdomain" {
  description = "Subdomain name of the admin portal service (like admin.example.co)"
  type        = string
  default     = "admin.example.co"
}


variable "api_subdomain_dev" {
  description = "Subdomain name of the api service (like api.example.co)"
  type        = string
  default     = "dev.api.example.co"
}

variable "admin_subdomain_dev" {
  description = "Subdomain name of the admin portal service (like admin.example.co)"
  type        = string
  default     = "dev.admin.example.co"
}

variable "nameservers" {
  type    = list(string)
  default = ["ns63.domaincontrol.com", "ns64.domaincontrol.com"]
}

variable "api_service_name" {
  description = "A Docker image-compatible name for the service"
  type        = string
}

variable "admin_service_name" {
  description = "A Docker image-compatible name for the service"
  type        = string
}

variable "api_worker_service_name" {
  description = "A Docker image-compatible name for the service"
  type        = string
}
variable "web_service_name" {
  description = "A Docker image-compatible name for the service"
  type        = string
}


variable "sample_image" {
  description = "A Docker image the service"
  type        = string
  default     = "public.ecr.aws/nginx/nginx:stable-perl"
}


variable "scenario" {
  description = "Scenario name for tags"
  default     = "scenario-ecs-fargate"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "Dev"
  type        = string
}

variable "hosted_zone_id" {
  type        = string
  description = "ID of the existing hosted zone"
}


########################################################################################################################
## AWS credentials
########################################################################################################################

variable "aws_access_key_id" {
  description = "AWS console access key"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS console secret access key"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
  type        = string
}

########################################################################################################################
## Network variables
########################################################################################################################

variable "tld_zone_id" {
  description = "Top level domain hosted zone ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  type        = string
}

variable "az_count" {
  description = "Describes how many availability zones are used"
  default     = 1
  type        = number
}

########################################################################################################################
## ECS variables
########################################################################################################################

variable "ecs_task_desired_count" {
  description = "How many ECS tasks should run in parallel"
  type        = number
}

variable "ecs_task_min_count" {
  description = "How many ECS tasks should minimally run in parallel"
  default     = 1
  type        = number
}

variable "ecs_task_max_count" {
  description = "How many ECS tasks should maximally run in parallel"
  default     = 5
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 75
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 80
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

variable "admin_container_port" {
  description = "Port of the Admin container"
  type        = number
  default     = 3000
}

variable "api_container_port" {
  description = "Port of the API container"
  type        = number
  default     = 30040
}

variable "web_container_port" {
  description = "Port of the Web container"
  type        = number
  default     = 5173
}

variable "cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 512
  type        = number
}

########################################################################################################################
## Cloudwatch
########################################################################################################################

variable "retention_in_days" {
  description = "Retention period for Cloudwatch logs"
  default     = 7
  type        = number
}

########################################################################################################################
## ECR
########################################################################################################################

variable "ecr_force_delete" {
  description = "Forces deletion of Docker images before resource is destroyed"
  default     = true
  type        = bool
}

variable "hash" {
  description = "Task hash that simulates a unique version for every new deployment of the ECS Task"
  type        = string
}

########################################################################################################################
## ALB
########################################################################################################################

variable "custom_origin_host_header" {
  description = "Custom header to ensure communication only through CloudFront"
  default     = "exampleCloudFront"
  type        = string
}

variable "healthcheck_endpoint" {
  description = "Endpoint for ALB healthcheck"
  type        = string
  default     = "/"
}

variable "healthcheck_matcher" {
  description = "HTTP status code matcher for healthcheck"
  type        = string
  default     = "200"
}


variable "example_api_secrets_dev" {
  type = map(string)
  default = {
    API_BASE_URL                 = "your-secret-id-for-API_BASE_URL",
    JWT_AUDIENCE                 = "your-secret-id-for-JWT_AUDIENCE"
  }
}

variable "example_api_secrets_prod" {
  type = map(string)
  default = {
    API_BASE_URL                 = "your-secret-id-for-API_BASE_URL",
    JWT_AUDIENCE                 = "your-secret-id-for-JWT_AUDIENCE"
  }
}