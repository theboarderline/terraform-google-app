

resource "google_cloudbuild_trigger" "cloudbuild_trigger" {
  project = var.app_project_id
  name    = "${var.lifecycle_name}-ci"

  disabled       = var.disabled
  included_files = var.included_files

  github {
    owner = var.github_owner
    name  = var.repo_name

    push {
      branch = var.lifecycle_name == "prod" ? "main" : var.lifecycle_name
    }
  }

  filename = var.filename

  substitutions = {
    _LIFECYCLE    = var.lifecycle_name
    _APP_CODE     = var.repo_name
    _DOMAIN       = var.domain
    _NAMESPACE    = "${var.lifecycle_name}-${var.repo_name}"
    _GKE_PROJECT  = var.gke_project_id
    _DB_PROJECT   = var.db_project_id

    _REGION  = var.region
    _ZONE    = var.zone
    _CLUSTER = var.cluster_name

    _FAILOVER_REGION  = var.failover_region
    _FAILOVER_ZONE    = var.failover_zone
    _FAILOVER_CLUSTER = var.failover_cluster_name

    _USE_HELM = var.use_helm
  }

}


