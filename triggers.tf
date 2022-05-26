

resource "google_cloudbuild_trigger" "cloudbuild_triggers" {
  for_each = toset(var.build_locations)

  project = var.app_project_id
  name    = "${var.lifecycle_name}-${each.key}-ci"

  # service_account = local.cicd_service_account
  disabled       = var.disabled
  included_files = ["${each.key}/**"]
  ignored_files  = var.ignored_files

  github {
    owner = var.github_owner
    name  = var.app_code

    push {
      branch = var.lifecycle_name == "prod" ? "^main$" : "^${var.lifecycle_name}$"
    }
  }

  build {

    step {
      id = "Build-React"
      name = "gcr.io/kaniko-project/executor:latest"
      args = [
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}-images/${each.key}:$COMMIT_SHA",
        "--destination=gcr.io/${var.app_project_id}/${local.app_label}-images/${each.key}:latest",
        "--context=./${each.key}",
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





