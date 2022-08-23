
resource "helm_release" "argocd" {
  count = !var.disabled && var.use_helm ? 1 : 0

  name             = local.namespace
  namespace        = local.namespace
  chart            = var.chart_path
  create_namespace = true

  values = [
    "${file("${var.chart_values_path}/${var.lifecycle_name}.yaml")}",
  ]

  set {
    name  = "web-app.app_code"
    value = var.app_code
  }

  set {
    name  = "web-app.lifecycle"
    value = var.lifecycle_name
  }

  set {
    name = "web-app.domain"
    value = local.full_domain
  }

  set {
    name = "web-app.gke_project_id"
    value = var.gke_project_id
  }

  set {
    name = "web-app.db_project_id"
    value = var.db_project_id
  }

}
