provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "app" {
  name = "my-spring-boot-app"
}

resource "aws_ecs_cluster" "app" {
  name = "spring-boot-app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "spring-boot-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "spring-boot-app-container",
      image     = "${aws_ecr_repository.app.repository_url}:latest",
      essential = true,
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "spring-boot-app-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [/* Your VPC Subnet IDs */]
    security_groups = [/* Your Security Group IDs */]
  }
}
