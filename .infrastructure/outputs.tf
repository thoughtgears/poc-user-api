output "artifact_repository_url" {
  value       = module.artifact_registry.url
  description = "Full URL to the artifact repository"
}

output "run_service_account" {
  value       = module.cloud_run.service_account_email
  description = "The email of the Cloud Run service account"
}