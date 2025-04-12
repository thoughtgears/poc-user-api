variable "dynamic_labels" {
  description = "Labels to be applied to all resources, user defined"
  type        = map(string)
  default     = {}
}

variable "module_labels" {
  description = "Labels to be applied to all resources in the module, based on module data"
  type        = map(string)
  default     = {}
}