
resource "google_dns_managed_zone" "dns_zone" {
  count = var.lifecycle_name == "ops" ? 1 : 0

  project = var.app_project_id

  name     = var.dns_zone_name
  dns_name = "${var.domain}."
  dnssec_config {
    state = "on"
  }
}


resource "google_compute_global_address" "global_ip" {
  count = var.create_ip && !var.disabled ? 1 : 0

  project = var.gke_project_id
  name    = local.ip_name
}


resource "google_dns_record_set" "dns_record_set" {
  count = var.create_ip && !var.disabled ? 1 : 0

  project = var.app_project_id

  managed_zone = var.dns_zone_name
  name         = var.lifecycle_name == "prod" ? "${var.domain}." : "${var.lifecycle_name}.${var.domain}."
  type         = "A"
  rrdatas      = [google_compute_global_address.global_ip[0].address]
  ttl          = 86400

  depends_on = [
    google_dns_managed_zone.dns_zone,
    google_compute_global_address.global_ip,
  ]
}
