variable "project_id" {
  description = "The project ID to create the artifact repository in"
  type        = string
}

variable "location_id" {
  description = "The location to create the artifact repository in"
  type        = string
}

variable "retention" {
  description = "The retention period for the backup schedule in seconds. The maximum value is 14 weeks (8,467,200 seconds)."
  type        = string
  default     = "8467200s"

  validation {
    condition     = can(regex("^[0-9]+(\\.[0-9]{1,9})?s$", var.retention)) && tonumber(replace(var.retention, "s", "")) <= 8467200
    error_message = "The retention period must be a number with up to 9 decimal places followed by 's' and can't exceed 14 weeks (8,467,200 seconds)."
  }
}