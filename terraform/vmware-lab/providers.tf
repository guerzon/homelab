terraform {
  required_version = "~>1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.37"
    }
  }
  backend "gcs" {
    bucket = "terraform-gcp-portfolio-465603"
    prefix = "terraform/vmware-lab"
  }
}

provider "google" {
  project = var.project_id
}