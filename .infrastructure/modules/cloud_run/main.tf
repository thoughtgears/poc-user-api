resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = "run-${var.name}"
  display_name = "[RUN] ${var.name} Service Account"
  description  = "Service account for ${var.name} Cloud Run"
}

resource "google_project_iam_member" "this" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.this.email}"
  role    = "roles/iam.serviceAccountUser"
}