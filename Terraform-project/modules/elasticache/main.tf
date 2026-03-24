# -------------------------
# Subnet Group
# -------------------------

resource "aws_elasticache_subnet_group" "redis" {
  name       = "shopyyy-redis-subnet"
  subnet_ids = var.private_subnets
}

# -------------------------
# Redis Cluster
# -------------------------

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "shopyyy-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  port                 = 6379

  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [var.redis_sg]
}
