

variable "lifecycle_name" {
  description = "Lifecycle name"
  type        = string
}


variable "repo_name" {
  description = "Name of application code repo in Github"
  type        = string
}


variable "domain" {
  description = "DNS Domain"
  type        = string
}


variable "gke_project_id" {
  description = "GKE project ID"
  type        = string
}


variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "central-cluster"
}


variable "failover_cluster_name" {
  description = "Failover GKE cluster name"
  type        = string
  default     = "east-cluster"
}

variable "app_project_id" {
  description = "App project ID"
  type        = string
}


variable "github_owner" {
  description = "Github repo owner"
  type        = string
  default     = "theboarderline"
}



variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}


variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}


variable "failover_region" {
  description = "GCP failover region"
  type        = string
  default     = "us-east4"
}


variable "failover_zone" {
  description = "GCP failover zone"
  type        = string
  default     = "us-east4-b"
}


variable "dns_zone_name" {
  description = "Cloud DNS Zone name"
  type        = string
  default     = "dns-zone"
}


variable "filename" {
  description = "Cloudbuild script filepath"
  type        = string
  default     = "cloudbuild.yaml"
}


variable "included_files" {
  description = "List of included files for cloudbuild"
  type        = list(string)
  default = [
    "nginx/**",
    "api/**",
    "cloudbuild.yaml",
  ]
}


variable "admin" {
  description = "GCP Bucket Admin"
  type        = string
  default     = ""
}


variable "create_ip" {
  description = "Whether external IP and DNS A record should get created"
  type        = bool
  default     = true
}


variable "disabled" {
  description = "Whether CICD should be disabled and IP address deleted"
  type        = string
  default     = false
}


variable "force_destroy" {
  description = "Whether storage buckets should get destroyed even if there are objects within"
  type        = string
  default     = true
}


variable "use_helm" {
  description = "Whether CICD should be deploy using helm or not"
  type        = string
  default     = false
}


