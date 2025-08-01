variable "resource_group_name" {
  default = "tsala-cv_group-bd8a"
}

variable "location" {
  default = "West Europe"
}

variable "app_name" {
  default = "tsala-cv-html-app"
}

variable "ARM_CLIENT_SECRET" {
  description = "Secret client Azure"
  type        = string
  sensitive   = true
}