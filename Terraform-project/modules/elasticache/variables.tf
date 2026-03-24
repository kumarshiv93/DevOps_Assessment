variable "private_subnets" {
  type = list(string)
}

variable "redis_sg" {
  type = string
}

variable "node_type" {
  type = string
}
