

locals {
  lifecycle_letter = substr(var.lifecycle_name, 0, 1)

  force_destroy = var.lifecycle_name == "prod" ? false : var.force_destroy

  ip_name = "${var.lifecycle_name}-${var.repo_name}-ip"

  cicd_service_account = "projects/${var.app_project_id}/serviceAccounts/${var.lifecycle_name}-${var.repo_name}-cicd@${var.app_project_id}.iam.gserviceaccount.com"
}



