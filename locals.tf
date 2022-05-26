

locals {
  namespace = "${var.lifecycle_name}-${var.app_code}"

  app_label = var.label == "" ? local.namespace : "${local.namespace}-${var.label}"

  lifecycle_letter = substr(var.lifecycle_name, 0, 1)

  force_destroy = var.lifecycle_name == "prod" ? false : var.force_destroy

  ip_name = "${local.app_label}-ip"

  cicd_service_account = "projects/${var.app_project_id}/serviceAccounts/${local.namespace}-cicd@${var.app_project_id}.iam.gserviceaccount.com"

  full_domain = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain

}



