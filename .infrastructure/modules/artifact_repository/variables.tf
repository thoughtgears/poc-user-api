variable "project_id" {
  description = "The project ID to create the artifact repository in"
  type        = string
}

variable "location_id" {
  description = "The location to create the artifact repository in"
  type        = string
}

variable "environment" {
  description = "The environment to create the artifact repository in"
  type        = string
}

variable "name" {
  description = "The name of the artifact repository"
  type        = string
}

variable "read_permissions" {
  type        = list(string)
  description = "The permissions allowed access to push sources from the artifact repository, should include a list of principals with the correct prefixes, user: or serviceAccount:"
  default     = []

  validation {
    condition     = alltrue([for principal in var.read_permissions : can(regex("^(user:|serviceAccount:)", principal))])
    error_message = "All principals must start with user: or serviceAccount:"
  }
}

variable "push_permissions" {
  type        = list(string)
  description = "The permissions allowed access to push sources from the artifact repository, should include a list of principals with the correct prefix, serviceAccount:"
  default     = []

  validation {
    condition     = alltrue([for principal in var.push_permissions : can(regex("^(serviceAccount:)", principal))])
    error_message = "All principals must start with serviceAccount:"
  }
}