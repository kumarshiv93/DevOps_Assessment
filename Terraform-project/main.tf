module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  project     = var.project
  environment = var.environment
}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id
}

module "route53_acm" {
  source = "./modules/route53-acm"

  domain_name = var.domain_name
}

module "s3" {
  source = "./modules/s3"

  project     = var.project
  environment = var.environment
}

module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_sg         = module.security_groups.alb_sg
  certificate_arn = module.route53_acm.alb_certificate_arn
}

module "ecs" {
  source = "./modules/ecs"

  private_subnets = module.vpc.private_subnet_ids
  ecs_sg          = module.security_groups.ecs_sg
  target_group_arn = module.alb.target_group_arn

  container_image = var.container_image
}

module "rds" {
  source = "./modules/rds"

  private_subnets = module.vpc.private_subnet_ids
  rds_sg          = module.security_groups.rds_sg

  db_instance_class = var.db_instance_class
}

module "elasticache" {
  source = "./modules/elasticache"

  private_subnets = module.vpc.private_subnet_ids
  redis_sg        = module.security_groups.redis_sg

  node_type = var.redis_node_type
}

module "msk" {
  source = "./modules/msk"

  private_subnets = module.vpc.private_subnet_ids
  msk_sg          = module.security_groups.msk_sg

  instance_type = var.msk_instance_type
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name = module.s3.bucket_name
  alb_dns     = module.alb.alb_dns

  domain_name = var.domain_name
  certificate_arn = module.route53_acm.cloudfront_certificate_arn
}
