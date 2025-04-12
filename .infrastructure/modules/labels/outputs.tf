output "all" {
  value       = local.all_labels
  description = "All merged labels to use in a resource"
}

output "default" {
  value       = local.defualt_labels
  description = "Default labels to use in a resource"
}

output "dynamic" {
  value       = var.dynamic_labels
  description = "Dynamic labels to use in a resource"
}

output "module" {
  value       = var.module_labels
  description = "Module labels to use in a resource"
}