
resource "time_rotating" "key_rotation" {
  count         = !var.disabled && var.use_django ? 1 : 0
  rotation_days = 30
}


resource "google_service_account_key" "key" {
  count = !var.disabled && var.use_django ? 1 : 0

  project            = var.gcp_project_id
  service_account_id = var.service_account

  keepers = {
    rotation_time = time_rotating.key_rotation[0].rotation_rfc3339
  }
}

