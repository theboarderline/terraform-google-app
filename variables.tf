

variable "label" {
  description = "App label"
  type        = string
  default     = ""
}


variable "app_code" {
  description = "App team code"
  type        = string
  default     = ""
}


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


variable "subdomain" {
  description = "DNS sub Domain"
  type        = string
  default     = ""
}


variable "gke_project_id" {
  description = "GKE project ID"
  type        = string
}


variable "db_project_id" {
  description = "Database project ID"
  type        = string
}


variable "dns_project_id" {
  description = "DNS project ID"
  type        = string
}


variable "app_project_id" {
  description = "App project ID"
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


variable "github_owner" {
  description = "Github repo owner"
  type        = string
  default     = "theboarderline"
}


variable "admin" {
  description = "GCP Bucket Admin"
  type        = string
  default     = ""
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


variable "create_dns_zone" {
  description = "Whether Cloud DNS zone should get created"
  type        = bool
  default     = false
}


variable "create_record_set" {
  description = "Whether Cloud DNS record set should get created"
  type        = bool
  default     = false
}


variable "dns_zone_name" {
  description = "Cloud DNS Zone name"
  type        = string
  default     = "dns-zone"
}


variable "included_files" {
  description = "List of included files for cloudbuild"
  type        = list(string)
  default     = ["src/**"]
}


variable "ignored_files" {
  description = "List of ignored files for cloudbuild"
  type        = list(string)
  default     = ["src/mobile/**"]
}


variable "build_locations" {
  description = "List of directories to attach CI trigger to"
  type        = list(string)
  default = [
    "react",
    "api",
  ]
}


variable "namespaces" {
  description = "List of namespaces to make monitoring dashboards for"
  type        = list(string)
  default     = []
}


variable "create_ip" {
  description = "Whether external IP and DNS A record should get created"
  type        = bool
  default     = false
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
  default     = true
}


variable "cicd_machine_type" {
  description = "Cloudbuild VM machine type"
  type        = string
  default     = ""
}


variable "logging" {
  description = "GCP Bucket Admin"
  type        = string
  default     = "LEGACY"
}


variable "trigger_timeout" {
  description = "Cloud build trigger timeout"
  type        = string
  default     = "1800s"
}


variable "notification_channel" {
  description = "List of notification channels for alerts"
  type        = string
  default     = "4610371196665423148"
}


variable "create_registry" {
  description = "Whether artifact registry repos should be created"
  type        = bool
  default     = false
}


variable "separate_ci" {
  description = "Whether cloudbuild triggers should build each container separately, or together and use Helm for CD"
  type        = bool
  default     = false
}


variable "monitoring_suite" {
  description = "Whether monitoring resources should be created"
  type        = bool
  default     = true
}


variable "uptime_trigger_count" {
  description = "Integer representing the number of failed checks before triggering an alert"
  type        = number
  default     = 1
}


variable "uptime_trigger_duration" {
  description = "Amount of time that a time series must fail to report new data to be considered failing"
  type        = string
  default     = "300s"
}


variable "selected_regions" {
  description = "List of regions to use in uptime checks"
  type        = list(string)
  default = [
    "USA",
  ]
}


variable "create_trigger" {
  description = "Whether Cloudbuild trigger should get created"
  type        = bool
  default     = true
}


variable "create_buckets" {
  description = "Whether Cloud Storage Buckets should get created"
  type        = bool
  default     = true
}


variable "create_k8s_secrets" {
  description = "Whether secrets should get created using the K8s TF provider"
  type        = bool
  default     = true
}


variable "secrets_list" {
  description = "List of GSM secret names"
  type        = list(string)
  default     = []
}


variable "app_chart_repo" {
  description = "Application helm chart repo url"
  type        = string
  default     = "theboarderline.github.io/helm-charts"
}


variable "chart_name" {
  description = "Name of application helm chart"
  type        = string
  default     = "web-app"
}


variable "chart_values_path" {
  description = "Path to application helm chart values files (one per lifecycle)"
  type        = string
  default     = "./helm/values"
}


variable "chart_version" {
  description = "Application helm chart version"
  type        = string
  default     = "0.3.45"
}


