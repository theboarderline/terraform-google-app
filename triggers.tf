

resource "google_cloudbuild_trigger" "cloudbuild_triggers" {
  for_each = var.create_trigger && var.separate_ci ? toset(var.build_locations) : toset([])

  project = var.app_project_id
  name    = "${local.lifecycle_name}-${each.key}-ci"

  # service_account = local.cicd_service_account
  disabled       = var.disabled
  included_files = ["${each.key}/**"]
  ignored_files  = var.ignored_files

  github {
    owner = var.github_owner
    name  = var.app_code

    push {
      branch = local.lifecycle_name == "prod" ? "^main$" : "^${local.lifecycle_name}$"
    }
  }

  build {
    timeout = var.trigger_timeout

    step {
      id = "Build-${each.key}"
      name = "gcr.io/kaniko-project/executor:latest"
      args = [
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}/${each.key}:$COMMIT_SHA",
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}/${each.key}:latest",
        "--context=./src/${each.key}",
        "--cache=true",
        "--cache-ttl=240h"
      ]
    }

    step {
      id = "Deploy-${each.key}"
      name = "gcr.io/walker-cpl/helm-cd"
      env = [
        "CLUSTER_NAME = ${var.cluster_name}"
        "ZONE         = ${var.zone}"
        "REGION       = ${var.region}"
        "PROJECT      = ${var.gke_project_id}"
        "NAMESPACE    = ${local.namespace}"
      ]
    }

    options {
      machine_type = var.cicd_machine_type
      logging      = var.logging
    }
  }

}





resource "google_cloudbuild_trigger" "cloudbuild_trigger_legacy" {
  count = var.create_trigger && !var.separate_ci ? 1 : 0

  project = var.app_project_id
  name    = "${local.app_label}-cicd"

  disabled       = var.disabled
  included_files = var.included_files
  ignored_files  = var.ignored_files

  github {
    owner = var.github_owner
    name  = var.app_code

    push {
      branch = local.lifecycle_name == "prod" ? "^main$" : "^${local.lifecycle_name}$"
    }
  }

  filename = "cloudbuild.yaml"

  substitutions = {
    _LIFECYCLE    = local.lifecycle_name
    _APP_CODE     = var.app_code
    _NAMESPACE    = local.namespace
    _DOMAIN       = local.full_domain
    _GKE_PROJECT  = var.gke_project_id
    _DB_PROJECT   = var.db_project_id

    _REGION  = var.region
    _ZONE    = var.zone
    _CLUSTER = var.cluster_name

    _FAILOVER_REGION  = var.failover_region
    _FAILOVER_ZONE    = var.failover_zone
    _FAILOVER_CLUSTER = var.failover_cluster_name

    _USE_HELM = var.use_helm

    _IMAGE_REPO_NAME        = "${local.app_label}-images"
    _IP_NAME                = local.ip_name
    _PUBLIC_BUCKET_NAME     = "${local.app_label}-web-static"
    _INGEST_BUCKET_NAME     = "${local.app_label}-ingest"
    _CLEAN_DATA_BUCKET_NAME = "${local.app_label}-cleaned-data"
  }

}


