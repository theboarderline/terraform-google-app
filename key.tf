
resource "time_rotating" "key_rotation" {
  rotation_days = 30
}


resource "google_service_account_key" "key" {
  count = !var.disabled && var.use_django != "" ? 1 : 0

  service_account_id = var.service_account

  keepers = {
    rotation_time = time_rotating.key_rotation.rotation_rfc3339
  }
}

