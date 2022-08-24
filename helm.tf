
resource "helm_release" "app" {
  count = !var.disabled && var.use_helm ? 1 : 0

  repository = "https://${var.app_chart_repo}"
  chart      = var.chart_name
  version    = var.chart_version

  name             = local.namespace
  namespace        = local.namespace
  create_namespace = true

  values = [
    "${file("${var.chart_values_path}/${local.lifecycle_name}.yaml")}",
    "${file("${var.chart_values_path}/values.yaml")}",
  ]

  set {
    name  = "app_code"
    value = var.app_code
  }

  set {
    name  = "lifecycle"
    value = local.lifecycle_name
  }

  set {
    name  = "domain"
    value = local.full_domain
  }

  set {
    name  = "gke_project_id"
    value = var.gke_project_id
  }

  set {
    name  = "db_project_id"
    value = var.db_project_id
  }

  wait         = false
  reuse_values = true

}
