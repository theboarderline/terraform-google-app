
resource "google_artifact_registry_repository" "docker_repos" {
  provider = google-beta

  project = var.app_project_id

  location      = var.region
  repository_id = var.lifecycle_name
  format        = "DOCKER"
}



