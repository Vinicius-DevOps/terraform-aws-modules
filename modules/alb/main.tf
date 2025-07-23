# Application Load Balancer (ALB)
resource "aws_lb" "main" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
  enable_deletion_protection = false # True for enabling deletion protection

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

# Target Group
resource "aws_lb_target_group" "main" {
  name        = var.target_group_name != null ? var.target_group_name : "${var.name}-tg"
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.target_group_protocol
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200" # Status code 200
  }

  tags = merge(
    {
      Name = "${var.name}-tg"
    },
    var.tags
  )
}

# Listener HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = merge(
    {
      Name = "${var.name}-listener"
    },
    var.tags
  )
}