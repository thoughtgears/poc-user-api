terraform {
  required_version = "> 1.10.0"

  backend "gcs" {
    bucket = "thoughtgears-terraform-states"
    prefix = "poc-user-api"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}