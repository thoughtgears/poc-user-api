locals {
  service_apis = [
    "clouddeploy.googleapis.com"
  ]

  cloud_deploy_service_agent_roles = [
    "roles/iam.serviceAccountUser",
    "roles/clouddeploy.jobRunner",
    "roles/clouddeploy.releaser",
    "roles/run.developer"
  ]
}

resource "google_project_service" "this" {
  for_each = toset(local.service_apis)

  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_clouddeploy_delivery_pipeline" "this" {
  project  = var.project_id
  location = var.region
  name     = var.name
}

resource "google_project_iam_member" "cloud_deploy_service_agent" {
  for_each = toset(local.cloud_deploy_service_agent_roles)

  project = var.project_id
  member  = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
  role    = each.key

  serial_pipeline {
    stages {
      deploy_parameters {
        values = {
          deployParameterKey = "deployParameterValue"
        }

        match_target_labels = {}
      }

      profiles  = ["example-profile-one", "example-profile-two"]
      target_id = "example-target-one"
    }

    stages {
      profiles  = []
      target_id = "example-target-two"
    }
  }

  annotations = {
    my_first_annotation = "example-annotation-1"

    my_second_annotation = "example-annotation-2"
  }

  labels = {
    my_first_label = "example-label-1"

    my_second_label = "example-label-2"
  }
}