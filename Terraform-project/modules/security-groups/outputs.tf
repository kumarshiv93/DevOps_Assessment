output "alb_sg" {
  value = aws_security_group.alb.id
}

output "ecs_sg" {
  value = aws_security_group.ecs.id
}

output "rds_sg" {
  value = aws_security_group.rds.id
}

output "redis_sg" {
  value = aws_security_group.redis.id
}

output "msk_sg" {
  value = aws_security_group.msk.id
}
