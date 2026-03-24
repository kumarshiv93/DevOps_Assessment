variable "private_subnets" {
  type = list(string)
}

variable "rds_sg" {
  type = string
}

variable "db_instance_class" {
  type = string
}
