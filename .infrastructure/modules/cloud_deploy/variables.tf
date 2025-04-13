variable "project_id" {
  description = "The project ID to create the artifact repository in"
  type        = string
}

variable "project_number" {
  description = "The project number to create the artifact repository in"
  type        = string
}

variable "region" {
  description = "The default region to create the resources in"
  type        = string
}

variable "name" {
  description = "The name of the cloud deploy pipeline"
  type        = string
}