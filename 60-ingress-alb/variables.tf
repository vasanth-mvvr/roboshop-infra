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

variable "zone_name" {
  default = "vasanthreddy.space"
}
