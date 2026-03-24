# -----------------------
# ALB Security Group
# -----------------------

resource "aws_security_group" "alb" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTPS from CloudFront"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------
# ECS Security Group
# -----------------------

resource "aws_security_group" "ecs" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ecs_from_alb" {
  type                     = "ingress"
  from_port               = 3000
  to_port                 = 3000
  protocol                = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.ecs.id
}

# -----------------------
# RDS SG
# -----------------------

resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rds_from_ecs" {
  type                     = "ingress"
  from_port               = 5432
  to_port                 = 5432
  protocol                = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.rds.id
}

# -----------------------
# Redis SG
# -----------------------

resource "aws_security_group" "redis" {
  name   = "redis-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "redis_from_ecs" {
  type                     = "ingress"
  from_port               = 6379
  to_port                 = 6379
  protocol                = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.redis.id
}

# -----------------------
# MSK SG
# -----------------------

resource "aws_security_group" "msk" {
  name   = "msk-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "msk_from_ecs" {
  type                     = "ingress"
  from_port               = 9092
  to_port                 = 9092
  protocol                = "tcp"
  source_security_group_id = aws_security_group.ecs.id
  security_group_id        = aws_security_group.msk.id
}
