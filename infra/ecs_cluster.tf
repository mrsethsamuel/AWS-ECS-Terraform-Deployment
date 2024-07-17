########################################################################################################################
## Creates an ECS Cluster
########################################################################################################################

resource "aws_ecs_cluster" "default" {
  name = "${var.namespace}-cluster"

  tags = {
    Name     = "${var.namespace}-cluster"
    Scenario = var.scenario
  }
}