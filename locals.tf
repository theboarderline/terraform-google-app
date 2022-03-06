

locals {
  lifecycle_letter = substr(var.lifecycle_name, 0, 1)

  namespaces = length(var.namespaces) > 0 ? var.namespaces : [var.repo_name]

  force_destroy = var.lifecycle_name == "prod" ? false : var.force_destroy

  ip_name = "${var.lifecycle_name}-${var.repo_name}-ip"

  cpl_sa_project_id = "${local.lifecycle_letter}-cpl-svc-acct-project"
  cicd_service_account = "${var.lifecycle_name}-${var.repo_name}-cicd@${local.cpl_sa_project_id}.iam.gserviceaccount.com"
}



