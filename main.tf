
locals {
  namespaces = length(var.namespaces) > 0 ? var.namespaces : [var.repo_name]
}


