module "bucket" {
  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${var.lifecycle_name}-${var.repo_name}-web-static"
  project_id = var.app_project_id
  location   = var.region

  force_destroy = var.force_destroy

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  }]
}


module "private_bucket" {
  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${var.lifecycle_name}-${var.repo_name}-private"
  project_id = var.app_project_id
  location   = var.region

  iam_members = var.admin != "" ? [{
    role   = "roles/storage.objectAdmin"
    member = var.admin
  }] : []
}


module "cleaned_bucket" {
  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${var.lifecycle_name}-${var.repo_name}-cleaned-data"
  project_id = var.app_project_id
  location   = var.region

  iam_members = var.admin != "" ? [{
    role   = "roles/storage.objectAdmin"
    member = var.admin
  }] : []
}

 
module "ingest_bucket" {
  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${var.lifecycle_name}-${var.repo_name}-ingest"
  project_id = var.app_project_id
  location   = var.region

  iam_members = var.admin != "" ? [{
    role   = "roles/storage.objectAdmin"
    member = var.admin
  }] : []
}
