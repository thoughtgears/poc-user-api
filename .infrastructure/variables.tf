variable "project_id" {
  description = "The project ID to create the resources in"
  type        = string
}

variable "project_number" {
  description = "The project number to create the resources in"
  type        = string
}

variable "region" {
  description = "The default region to create the resources in"
  type        = string
}

variable "repository_name" {
  description = "The name of the github repository"
  type        = string
}

variable "repository_owner" {
  description = "The owner of the github repository"
  type        = string
}

variable "service_name" {
  description = "The name of the service service"
  type        = string
}