output "artifact_repository_url" {
  value       = "${local.region}-docker.pkg.dev/${local.project_id}/user-api"
  description = "Full URL to the artifact repository"
}