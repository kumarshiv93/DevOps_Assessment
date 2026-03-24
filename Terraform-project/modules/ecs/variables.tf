variable "private_subnets" {
  type = list(string)
}

variable "ecs_sg" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "container_image" {
  type = string
}
