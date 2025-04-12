locals {
  defualt_labels = {
    "module_owner" = "platform"
    "terraform"    = "true"
  }

  all_labels = merge(
    local.defualt_labels,
    var.dynamic_labels,
    var.module_labels
  )
}