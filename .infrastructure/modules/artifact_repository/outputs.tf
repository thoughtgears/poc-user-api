output "id" {
  value       = google_artifact_registry_repository.this.id
  description = "The ID of the artifact repository"
}

output "name" {
  value       = google_artifact_registry_repository.this.name
  description = "The name of the artifact repository"
}