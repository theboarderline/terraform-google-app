

locals {
  app_label = var.label == "" ? "${var.lifecycle_name}-${var.app_code}" : "${var.lifecycle_name}-${var.app_code}-${var.label}"

  lifecycle_letter = substr(var.lifecycle_name, 0, 1)

  force_destroy = var.lifecycle_name == "prod" ? false : var.force_destroy

  ip_name = "${local.app_label}-ip"

  cicd_service_account = "projects/${var.app_project_id}/serviceAccounts/${var.lifecycle_name}-${var.app_code}-cicd@${var.app_project_id}.iam.gserviceaccount.com"

}



