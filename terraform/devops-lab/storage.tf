resource "google_compute_disk" "default" {
  name = "devops-storage"
  size = 50
  zone = "${var.region}-a"
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = module.node1.instance_id
}