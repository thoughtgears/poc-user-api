# Should be imported by global or gotten from spacelift
locals {
  project_id = "shared-services-47252"
  region     = "europe-west1"
}

resource "google_artifact_registry_repository" "this" {
  project       = local.project_id
  format        = "DOCKER"
  repository_id = "user-api"
  location      = local.region
}

resource "google_firestore_database" "this" {
  project                           = local.project_id
  location_id                       = local.region
  name                              = "(default)"
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_ENABLED"
  deletion_policy                   = "ABANDON"
}

resource "google_firestore_backup_schedule" "this" {
  project   = local.project_id
  database  = google_firestore_database.this.name
  retention = "8467200s"

  daily_recurrence {}
}