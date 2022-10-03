

locals {
  lifecycle_name = var.lifecycle_name == "main" ? "prod" : var.lifecycle_name

  namespace = "${local.lifecycle_name}-${var.app_code}"

  app_label = var.label == "" ? local.namespace : "${local.namespace}-${var.label}"

  lifecycle_letter = substr(local.lifecycle_name, 0, 1)

  force_destroy = local.lifecycle_name == "prod" ? false : var.force_destroy

  ip_name = "${local.app_label}-ip"

  cicd_service_account = "projects/${var.app_project_id}/serviceAccounts/${local.namespace}-cicd@${var.app_project_id}.iam.gserviceaccount.com"

  full_domain = var.subdomain != "" ? "${var.subdomain}.${var.domain}" : var.domain

  app_dns_zone = var.dns_zone_name != "" ? var.dns_zone_name : "${var.app_code}-dns-zone"

  initial_app_secrets_map = {
    for key, val in data.google_secret_manager_secret_version.secrets_data : key => val.secret_data
  }

  oauth_secrets_map = {
    for key, val in data.google_secret_manager_secret_version.oauth_secrets : key => val.secret_data
  }

  sendgrid_secret_map = {
    for key, val in data.google_secret_manager_secret_version.sendgrid_secret : key => val.secret_data
  }

  twilio_secrets_map = {
    for key, val in data.google_secret_manager_secret_version.twilio_secrets : key => val.secret_data
  }

  maybe_oauth_secrets = var.use_google_oauth ? merge(local.initial_app_secrets_map, local.oauth_secrets_map) : local.initial_app_secrets_map
  maybe_sendgrid_secrets = var.use_sendgrid ? merge(local.maybe_oauth_secrets, local.sendgrid_secret_map) : local.maybe_oauth_secrets
  app_secrets_map = var.use_twilio ? merge(local.maybe_sendgrid_secrets, local.twilio_secrets_map) : local.maybe_sendgrid_secrets
}


