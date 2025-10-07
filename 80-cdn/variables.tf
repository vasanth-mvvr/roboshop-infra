variable "project_name" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Name = "roboshop"
    environment = "dev"
    Terraform = "true"
    component = "cdn"
  }

}

variable "zone_name" {
  default = "vasanthreddy.space"
}
