# -------------------------
# ECS Cluster
# -------------------------

resource "aws_ecs_cluster" "main" {
  name = "shopyyy-ecs-cluster"
}

# -------------------------
# IAM Role for ECS Task
# -------------------------

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-shopyyy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# -------------------------
# Task Definition
# -------------------------

resource "aws_ecs_task_definition" "task" {
  family                   = "shopyyy-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "shopyyy-container"
      image = var.container_image

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

      environment = [
        {
          name  = "DB_URL"
          value = "postgres://example"
        },
        {
          name  = "REDIS_URL"
          value = "redis://example"
        }
      ]
    }
  ])
}

# -------------------------
# ECS Service
# -------------------------

resource "aws_ecs_service" "service" {
  name            = "shopyyy-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "shopyyy-container"
    container_port   = 3000
  }

  depends_on = [
    aws_ecs_task_definition.task
  ]
}
