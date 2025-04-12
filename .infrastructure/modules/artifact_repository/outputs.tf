output "id" {
  value       = google_artifact_registry_repository.this.id
  description = "The ID of the artifact repository"
}

output "name" {
  value       = google_artifact_registry_repository.this.name
  description = "The name of the artifact repository"
}

output "url" {
  value       = "${var.location_id}-docker.pkg.dev/${var.project_id}/${var.name}"
  description = "Full URL to the artifact repository"
}