module "bucket" {
  count = var.create_buckets ? 1 : 0

  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${local.app_label}-web-static"
  project_id = var.app_project_id
  location   = var.region

  force_destroy = var.force_destroy

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  }]
}


module "cleaned_bucket" {
  count = var.create_buckets ? 1 : 0
  
  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${local.app_label}-cleaned-data"
  project_id = var.app_project_id
  location   = var.region

  # iam_members = var.admin != "" ? [{
  #   role   = "roles/storage.objectAdmin"
  #   member = var.admin
  # }] : []
}

 
module "ingest_bucket" {
  count = var.create_buckets ? 1 : 0

  source = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"

  name       = "${local.app_label}-ingest"
  project_id = var.app_project_id
  location   = var.region

  iam_members = var.admin != "" ? [{
    role   = "roles/storage.objectAdmin"
    member = var.admin
  }] : []
}
