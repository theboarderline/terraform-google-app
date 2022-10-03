
data "google_secret_manager_secret_version" "secrets_data" {
  for_each = var.use_django ? toset(concat(var.secrets_list, [var.django_secret_name])) : toset(var.secrets_list)

  secret  = each.key
  project = var.app_project_id
}


data "google_secret_manager_secret_version" "oauth_secrets" {
  for_each = var.use_google_oauth ? toset(var.oauth_secret_names) : toset([])

  secret  = each.key
  project = var.app_project_id
}


data "google_secret_manager_secret_version" "sendgrid_secret" {
  count = var.use_sendgrid ? 1 : 0

  secret  = var.sendgrid_secret_name
  project = var.app_project_id
}


data "google_secret_manager_secret_version" "twilio_secrets" {
  for_each = var.use_twilio ? toset(var.twilio_secret_names) : toset([])

  secret  = each.key
  project = var.app_project_id
}


