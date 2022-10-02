
data "google_secret_manager_secret_version" "secrets_data" {
  for_each = toset(var.secrets_list)

  secret  = each.key
  project = var.app_project_id
}


resource "kubernetes_secret" "app_secrets" {
  count = !var.disabled ? 1 : 0

  metadata {
    name      = "app-secrets"
    namespace = local.namespace
  }

  type = "Opaque"

  data = {
    for key, val in data.google_secret_manager_secret_version.secrets_data : key => val.secret_data
  }

  depends_on = [
    helm_release.app,
  ]
}

