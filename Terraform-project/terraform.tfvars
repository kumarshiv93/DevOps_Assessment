aws_region = "ap-south-1"

project     = "shopyyy"
environment = "dev"

domain_name = "shopyyy.com"

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

container_image = "nginx:latest"

db_instance_class = "db.t3.medium"

redis_node_type = "cache.t3.micro"

msk_instance_type = "kafka.t3.small"
