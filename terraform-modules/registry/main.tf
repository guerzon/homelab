resource "google_artifact_registry_repository" "default" {
  location      = var.location
  repository_id = var.registry_id
  format        = var.registry_format

  cleanup_policies {
    action = "KEEP"
    id     = "Tagged 5 latest"
    most_recent_versions {
      keep_count = 5
    }
  }

  cleanup_policies {
    action = "KEEP"
    id     = "Untagged 1-day old"
    most_recent_versions {
      keep_count = 1
    }
  }

  docker_config {
    immutable_tags = false
  }
}