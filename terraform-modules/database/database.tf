resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "default" {
  name        = var.database_user
  instance    = google_sql_database_instance.default.name
  password_wo = var.database_password
}