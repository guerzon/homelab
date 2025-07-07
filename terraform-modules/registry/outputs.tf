output "registry" {
  description = "ID of the Artifact Registry"
  value       = google_artifact_registry_repository.default.id
}