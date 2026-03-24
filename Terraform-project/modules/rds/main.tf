# -------------------------
# Secrets Manager
# -------------------------

resource "aws_secretsmanager_secret" "db_secret" {
  name = "shopyyy-db-secret"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    username = "postgres"
    password = "Shopyyy123!"
  })
}

# -------------------------
# Subnet Group
# -------------------------

resource "aws_db_subnet_group" "db_subnet" {
  name       = "shopyyy-db-subnet"
  subnet_ids = var.private_subnets
}

# -------------------------
# RDS PostgreSQL
# -------------------------

resource "aws_db_instance" "postgres" {
  identifier = "shopyyy-postgres"

  engine         = "postgres"
  engine_version = "17"
  instance_class = var.db_instance_class

  allocated_storage = 20

  username = "postgres"
  password = "Shopyyy123!"

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.rds_sg]

  multi_az = true

  publicly_accessible = false

  skip_final_snapshot = true
}
