resource "aws_ecs_cluster" "xapp_cluster" {
  name = var.app_cluster_name
}

resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = var.availability_zones[0]
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = var.availability_zones[1]
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = var.availability_zones[2]
}

resource "aws_ecs_task_definition" "xapp_task" {
  family                   = var.app_task_famliy
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.app_task_name}",
      "image": "${var.ecr_repo_url}:0.0.1",
      "essential": true,
      "environment": [
        {
          "name": "API_KEY",
          "value": "_xoodEdJ9iTcWejMaIPopwcagkctu0zw"
        },
        {
          "name": "PRIVATE_KEY",
          "value": "c068f69fdaadd9896f96ce0eafd1fa5e21aefa2c43ead0b6d085c9a5459d1c25"
        },
        {
          "name": "MONGODB_URI",
          "value": "mongodb://admin:admin@ec2-18-214-56-113.compute-1.amazonaws.com:27017/"
        },
        {
          "name": "AWS_ACCESS_KEY_ID",
          "value": "ASIAT43JXY7MD7DNVT5D"
        },
        {
          "name": "AWS_SECRET_ACCESS_KEY",
          "value": "2VMu+TNb3uIiuPHF1TuRIltJp8k+GpWSjspGVea5"
        },
        {
          "name": "AWS_SESSION_TOKEN",
          "value": "IQoJb3JpZ2luX2VjEFQaCXVzLXdlc3QtMiJGMEQCIC4lDGEV6goJxzEhhsFGXcQ0gR9HniIVSaBl6QgCnBLfAiBewraX3uhxO8KroRSZIKTTevULrcycDGj5HD7v5P/4jiq+Agj9//////////8BEAAaDDI2ODEyMDM0NDUzNiIMDo7LYjYGVoQv5SIeKpICRrAzMXwOlpvsJ9vcmZHebLHTgzyfNmjqE0bzQnceDTTrZCh7i6xt0jx6fcgNCT/90jFaGzcdguHEvfO9eY/UUNkT+v8D3HP296HYwG6evaPkBvYV05Sj4SLckbZ7Q+DYeqFQ8VUSnMT9xialJLSCwLZyxDZBP9u4fpR7BlCpdiddWv2TAUn/mi/HjIUBH7xcqnXYio7QDI+RVfya+P48f0vH7BWWlQFiZaVsDOxU2RZgIq1vgxnZUJ+W0++k0wmeg+l+6ZWykqgwGcr9XcWG8q3AZRMzJSFR4fN65WLUKvbJ28wVs8Nst7B3iX8yLBaJg5UlW8Ww7xW/lVLp1h5GOKmNpBgXOdPNQlnrS3k0DRS/KzDm6/izBjqeAcrrdwUe/zKw6aspxyeb9jgHYo8VGUo4+JD33zsP4XepEBCbZecH9accg031QtJMKDHip6Rb2pP1TlWTrlGdSyFsGiBWDlCKmWou7bv92MJd7GdtAAKyPKvG/6/xABsEuz93HuwhPRSOZ60bJ1LkaUal2t6+GRXjL9zX/b7dTQUlAxFyU5su7DDIiMOUEdpEJUfaVxWYhlqGBHmWPPIK"
        },
        {
          "name": "AWS_REGION",
          "value": "us-east-1"
        }
      ],
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "healthCheck": {
        "retries": 2,
        "command": [ "CMD-SHELL", "curl -f http://localhost:3000/health || exit 1" ],
        "timeout": 15,
        "interval": 10,
        "startPeriod": 60
      },
      "memory": 2048,
      "cpu": 1024,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/${var.app_task_famliy}",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "${var.app_task_name}"
        }
      }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 2048
  cpu                      = 1024
  execution_role_arn       = "arn:aws:iam::268120344536:role/LabRole"
}

resource "aws_alb" "application_load_balancer" {
  name               = var.application_load_balancer_name
  load_balancer_type = "application"
  subnets = [
    "${aws_default_subnet.default_subnet_a.id}",
    "${aws_default_subnet.default_subnet_b.id}",
    "${aws_default_subnet.default_subnet_c.id}"
  ]
  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
}

resource "aws_security_group" "load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_ecs_service" "xapp_service" {
  name            = var.app_service_name
  cluster         = aws_ecs_cluster.xapp_cluster.id
  task_definition = aws_ecs_task_definition.xapp_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.xapp_task.family
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
