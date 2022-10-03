
resource "kubernetes_secret" "app_secrets" {
  count = !var.disabled && var.create_k8s_secrets ? 1 : 0

  metadata {
    name      = "app-secrets"
    namespace = local.namespace
  }

  type = "Opaque"

  data = merge({
    for key, val in data.google_secret_manager_secret_version.secrets_data : key => val.secret_data
  })

  depends_on = [
    helm_release.app,
  ]
}


resource "kubernetes_secret" "oauth_creds" {
  count = !var.disabled && var.create_k8s_secrets && var.use_google_oauth ? 1 : 0

  metadata {
    name      = "oauth-credentials"
    namespace = local.namespace
  }

  type = "Opaque"

  data = {
    client_id = lookup(data.google_secret_manager_secret_version.oauth_secrets, "google-oauth-id", "")
    client_secret = lookup(data.google_secret_manager_secret_version.oauth_secrets, "google-oauth-secret", "")
  }

  depends_on = [
    helm_release.app,
  ]
}

