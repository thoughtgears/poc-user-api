resource "google_firestore_database" "this" {
  project                           = var.project_id
  location_id                       = var.location_id
  name                              = "(default)"
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_ENABLED"
  deletion_policy                   = "ABANDON"
}

resource "google_firestore_backup_schedule" "this" {
  project   = var.project_id
  database  = google_firestore_database.this.name
  retention = var.retention

  daily_recurrence {}
}