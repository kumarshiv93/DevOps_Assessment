variable "private_subnets" {
  type = list(string)
}

variable "msk_sg" {
  type = string
}

variable "instance_type" {
  type = string
}
