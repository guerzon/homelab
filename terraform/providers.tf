# resource "google_storage_bucket" "terraform" {
#   name     = "terraform-${var.project_id}"
#   location = "Asia"
#   versioning {
#     enabled = true
#   }
#   uniform_bucket_level_access = true
# }

terraform {
  required_version = "~>1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.37"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>6.41"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>3.0"
    }
  }
  backend "gcs" {
    bucket = "terraform-gcp-portfolio-465603"
    prefix = "terraform/non-production"
  }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}