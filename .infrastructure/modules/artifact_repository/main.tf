module "labels" {
  source = "../labels"

  module_labels = {
    "module" = "artifact_registry"
    "repo"   = "poc-user-api"
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
}

resource "google_artifact_registry_repository_iam_member" "this" {
  for_each = toset(var.read_permissions)

  repository = google_artifact_registry_repository.this.name
  role       = "roles/artifactregistry.reader"
  member     = each.value
}

resource "google_artifact_registry_repository_iam_member" "push" {
  for_each = toset(var.push_permissions)

  repository = google_artifact_registry_repository.this.name
  role       = "roles/artifactregistry.createOnPushWriter"
  member     = each.value
}

