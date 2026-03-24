output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_domain
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "redis_endpoint" {
  value = module.elasticache.redis_endpoint
}
