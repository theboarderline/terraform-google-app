
module "bucket" {
  count = var.create_buckets ? 1 : 0

  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${local.app_label}-public-content"
  project_id = var.app_project_id
  location   = var.region

  force_destroy = var.force_destroy

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  }]
}


resource "google_storage_bucket" "backend_bucket" {
  project       = var.app_project_id
  name          = "${local.app_label}-backend-bucket"
  location      = var.region
  force_destroy = var.lifecycle_name != "prod"

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = false

}
