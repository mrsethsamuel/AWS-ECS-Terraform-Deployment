########################################################################################################################
## Define Target Tracking on ECS Cluster Task level
########################################################################################################################

resource "aws_appautoscaling_target" "admin_ecs_target_prod" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.admin-prod.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_target" "api_ecs_target_prod" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.api-prod.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_target" "api_worker_ecs_target_prod" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.api-worker-prod.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_target" "admin_ecs_target_dev" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.admin-dev.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_target" "api_ecs_target_dev" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.api-dev.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_target" "api_worker_ecs_target_dev" {
  max_capacity       = var.ecs_task_max_count
  min_capacity       = var.ecs_task_min_count
  resource_id        = "service/${aws_ecs_cluster.default.name}/${aws_ecs_service.api-worker-dev.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

########################################################################################################################
## Policy for CPU tracking
########################################################################################################################

resource "aws_appautoscaling_policy" "admin_ecs_cpu_policy_prod" {
  name               = "${var.namespace}-AdminCPUTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.admin_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.admin_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.admin_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}


resource "aws_appautoscaling_policy" "api_ecs_cpu_policy_prod" {
  name               = "${var.namespace}-APICPUTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.api_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "api_worker_ecs_cpu_policy_prod" {
  name               = "${var.namespace}-api-worker-CPU-Target-Tracking-Scaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_worker_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.api_worker_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_worker_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "admin_ecs_cpu_policy_dev" {
  name               = "${var.namespace}-AdminCPUTargetTrackingScaling-dev"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.admin_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.admin_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.admin_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}


resource "aws_appautoscaling_policy" "api_ecs_cpu_policy_dev" {
  name               = "${var.namespace}-APICPUTargetTrackingScaling-dev"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.api_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}


resource "aws_appautoscaling_policy" "api_worker_ecs_cpu_policy_dev" {
  name               = "${var.namespace}-api-worker-CPU-Target-Tracking-Scaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_worker_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.api_worker_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_worker_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

########################################################################################################################
## Policy for memory tracking
########################################################################################################################

resource "aws_appautoscaling_policy" "admin_ecs_memory_policy_prod" {
  name               = "${var.namespace}-AdminMemoryTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.admin_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.admin_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.admin_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "api_ecs_memory_policy_prod" {
  name               = "${var.namespace}-APIMemoryTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.api_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "api_worker__ecs_memory_policy_prod" {
  name               = "${var.namespace}-APIMemoryTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_worker_ecs_target_prod.resource_id
  scalable_dimension = aws_appautoscaling_target.api_worker_ecs_target_prod.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_worker_ecs_target_prod.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}


resource "aws_appautoscaling_policy" "admin_ecs_memory_policy_dev" {
  name               = "${var.namespace}-AdminMemoryTargetTrackingScaling-dev"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.admin_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.admin_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.admin_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "api_ecs_memory_policy" {
  name               = "${var.namespace}-APIMemoryTargetTrackingScaling-${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.api_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "api_worker__ecs_memory_policy_dev" {
  name               = "${var.namespace}-APIMemoryTargetTrackingScaling-prod"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api_worker_ecs_target_dev.resource_id
  scalable_dimension = aws_appautoscaling_target.api_worker_ecs_target_dev.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api_worker_ecs_target_dev.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}