

locals {
  namespaces = length(var.namespaces) > 0 ? var.namespaces : [var.repo_name]

  force_destroy = var.lifecycle_name == "prod" ? false : var.force_destroy
}



