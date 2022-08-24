

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
      id   = "Build-${each.key}"
      name = "gcr.io/kaniko-project/executor:latest"
      args = [
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}/${each.key}:$COMMIT_SHA",
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}/${each.key}:latest",
        "--context=./src/${each.key}",
        "--cache=true",
        "--cache-ttl=240h"
      ]
    }

    options {
      machine_type = var.cicd_machine_type
      logging      = var.logging
    }
  }

}



resource "google_cloudbuild_trigger" "mono_trigger" {
  count = var.create_trigger && !var.separate_ci ? 1 : 0

  project = var.app_project_id
  name    = "${local.lifecycle_name}-cicd"

  # service_account = local.cicd_service_account
  disabled       = var.disabled
  included_files = ["src/**"]
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
      id   = "Build-Backend"
      name = "gcr.io/kaniko-project/executor:latest"
      args = [
        "--destination=gcr.io/${var.app_project_id}/${var.lifecycle_name}/api:$COMMIT_SHA",
        "--destination=gcr.io/${var.app_project_id}/${var.lifecycle_name}/api:latest",
        "--context=./src/api",
        "--cache=true",
        "--cache-ttl=240h"
      ]
    }

    step {
      id   = "Build-Frontend"
      name = "gcr.io/kaniko-project/executor:latest"
      args = [
        "--destination=gcr.io/${var.app_project_id}/${var.lifecycle_name}/react:$COMMIT_SHA",
        "--destination=gcr.io/${var.app_project_id}/${var.lifecycle_name}/react:latest",
        "--context=./src/react",
        "--cache=true",
        "--cache-ttl=240h"
      ]
    }

    step {
      id   = "Refresh-Images"
      name = "gcr.io/walker-cpl/helm-cd"
      entrypoint = "/usr/bin/update.sh ${var.cluster_name} ${var.zone} ${var.gke_project_id} ${local.namespace} ${var.chart_version} $COMMIT_SHA"
    }


    options {
      machine_type = var.cicd_machine_type
      logging      = var.logging
    }
  }

}


