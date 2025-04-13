locals {
  service_apis = [
    "artifactregistry.googleapis.com"
  ]
}

resource "google_project_service" "this" {
  for_each = toset(local.service_apis)

  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
}

module "labels" {
  source = "../labels"

  module_labels = {
    "module" = "artifact_registry"
    "repo"   = "thoughtgears-modules"
  }

  dynamic_labels = {
    "project" = var.project_id
    "region"  = var.location_id
    "env"     = var.environment
  }
}

resource "google_artifact_registry_repository" "this" {
  project       = var.project_id
  format        = "DOCKER"
  repository_id = var.name
  location      = var.location_id

  labels = module.labels.all

  depends_on = [google_project_service.this["artifactregistry.googleapis.com"]]
}

resource "google_artifact_registry_repository_iam_member" "this" {
  for_each = toset(var.read_permissions)

  project    = google_artifact_registry_repository.this.project
  repository = google_artifact_registry_repository.this.id
  location   = google_artifact_registry_repository.this.location
  role       = "roles/artifactregistry.reader"
  member     = each.value
}

resource "google_artifact_registry_repository_iam_member" "push" {
  for_each = toset(var.push_permissions)

  project    = google_artifact_registry_repository.this.project
  repository = google_artifact_registry_repository.this.name
  location   = google_artifact_registry_repository.this.location
  role       = "roles/artifactregistry.createOnPushWriter"
  member     = each.value
}

