module "artifact_registry" {
  source = "./modules/artifact_repository"

  project_id  = var.project_id
  location_id = var.region
  name        = var.repository_name
  environment = "shared"

  read_permissions = [
    "user:jens.skott@thoughtgears.co.uk"
  ]

  push_permissions = [
    "serviceAccount:wif-gha-${var.repository_name}@shared-services-47252.iam.gserviceaccount.com"
  ]
}

module "firestore" {
  source = "./modules/firestore"

  project_id  = var.project_id
  location_id = var.region
}