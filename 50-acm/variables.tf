variable "project" {
  type = string
  default = "roboshop"

}

variable "environment" {
  type = string
  default = "dev"
}

variable "common_tags" {
  type = map
  default = {
    Name = "roboshop"
    environment = "dev"
    terraform = "true"
  }
}

variable "zone_id" {
  default = "Z0879685WB7OSJ4GGIDR"
}