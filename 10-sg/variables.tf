variable "project" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "common_tag" {
  type = map
  default = {
    Name = "roboshop"
    environment = "dev"
  }
}