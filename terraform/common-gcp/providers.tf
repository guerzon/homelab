resource "google_storage_bucket" "terraform" {
  name     = "terraform-sreafterhours-dev"
  location = "Asia"
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
  force_destroy               = false
}

terraform {
  required_version = "~>1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.37"
    }
  }
  backend "gcs" {
    bucket = "terraform-sreafterhours-dev"
    prefix = "terraform/common-gcp"
  }
}

provider "google" {
  project = var.project_id
}