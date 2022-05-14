

resource "google_cloudbuild_trigger" "cloudbuild_trigger_legacy" {
  project = var.app_project_id
  name    = "${local.app_label}-cicd"

  disabled       = var.disabled
  included_files = var.included_files
  ignored_files  = var.ignored_files
  # service_account = local.cicd_service_account

  github {
    owner = var.github_owner
    name  = var.repo_name

    push {
      branch = var.lifecycle_name == "prod" ? "main" : var.lifecycle_name
    }
  }

  filename = "cloudbuild.yaml"

  substitutions = {
    _LIFECYCLE    = var.lifecycle_name
    _APP_CODE     = var.app_code
    _NAMESPACE    = "${var.lifecycle_name}-${var.app_code}"
    _DOMAIN       = var.domain
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


# resource "google_cloudbuild_trigger" "cloudbuild_trigger" {
#   project = var.app_project_id
#   name    = "${var.lifecycle_name}-cicd"
#
#   disabled       = var.disabled
#   included_files = var.included_files
#
#   github {
#     owner = var.github_owner
#     name  = var.repo_name
#
#     push {
#       branch = var.lifecycle_name == "prod" ? "main" : var.lifecycle_name
#     }
#   }
#
#   service_account = local.cicd_service_account
#
#
#   build {
#
#     # step {
#     #   id = "Build-API"
#     #   name = "gcr.io/kaniko-project/executor:latest" 
#     #   args = [
#     #     "--destination=${var.region}-docker.pkg.dev/${var.app_project_id}/${var.lifecycle_name}/api:$COMMIT_SHA",
#     #     "--destination=${var.region}-docker.pkg.dev/${var.app_project_id}/${var.lifecycle_name}/api:latest",
#     #     "--context=./api",
#     #     "--cache=true",
#     #     "--cache-ttl=240h"
#     #   ]
#     # }
#     #
#     # step {
#     #   id = "Build-React"
#     #   name = "gcr.io/kaniko-project/executor:latest" 
#     #   args = [
#     #     "--destination=${var.region}-docker.pkg.dev/${var.app_project_id}/${var.lifecycle_name}/nginx:$COMMIT_SHA",
#     #     "--destination=${var.region}-docker.pkg.dev/${var.app_project_id}/${var.lifecycle_name}/nginx:latest",
#     #     "--context=./react",
#     #     "--cache=true",
#     #     "--cache-ttl=240h"
#     #   ]
#     # }
#
#     step {
#       id = "GKE-Auth"
#       name = "gcr.io/cloud-builders/gcloud-slim"
#       entrypoint = "bash"
#       args = [
#         "-c",
#         "gcloud container clusters get-credentials ${var.cluster_name} --zone=${var.zone} --project=${var.gke_project_id}"
#       ]
#     }
#
#     step {
#       id = "Helm-Upgrade"
#       name = "gcr.io/walker-cpl/helm"
#       entrypoint = "bash"
#       args = [
#         "-c",
#         "helm dep update ./charts/web-app && helm upgrade -i ${var.lifecycle_name}-${var.repo_name} ./charts/web-app -f ./charts/web-app/values/${var.lifecycle_name}.yaml -n ${var.lifecycle_name}-${var.repo_name} --set web-app.api.tag=$COMMIT_SHA --set web-app.nginx.tag=$COMMIT_SHA --set web-app.app_project_id=${var.app_project_id} --set web-app.gke_project_id=${var.gke_project_id} --set web-app.db_project_id=${var.db_project_id} --set web-app.google.domain=${var.domain} --set web-app.app_code=${var.repo_name}"
#       ]
#     }
#
#     options {
#       machine_type = var.cicd_machine_type
#       logging      = var.logging
#     }
#   }
#
# }


