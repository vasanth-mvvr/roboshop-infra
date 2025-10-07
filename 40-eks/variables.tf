variable "project" {
  type = string
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tag" {
  type = map
  default = {
    Name = "roboshop"
    environment = "dev"
  }
}