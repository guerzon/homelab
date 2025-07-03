resource "google_compute_backend_service" "backend" {
  name                  = "${var.environment}-backend-service-backend"
  description           = "Backend service for ${var.environment} environment"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = var.backend_port_name

  backend {
    group           = var.instancegroups.ig.main
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }
  health_checks = [google_compute_health_check.backend.id]
  log_config {
    enable      = true
    sample_rate = 1
  }
  security_policy  = var.security_policy_id
  session_affinity = "CLIENT_IP"
}

resource "google_compute_backend_service" "backend_backup" {
  count                 = var.build_backup ? 1 : 0
  name                  = "${var.environment}-backend-service-backend-backup"
  description           = "Backup backend service for ${var.environment} environment"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = var.backend_port_name

  backend {
    group           = var.instancegroups.ig.backup
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }
  health_checks = [google_compute_health_check.backend.id]
  log_config {
    enable      = true
    sample_rate = 1
  }
  security_policy  = var.security_policy_id
  session_affinity = "CLIENT_IP"
}

resource "google_compute_backend_service" "frontend" {
  name                  = "${var.environment}-backend-service-frontend"
  description           = "Backend service for ${var.environment} environment"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = var.frontend_port_name

  backend {
    group           = var.instancegroups.ig.main
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }
  log_config {
    enable      = true
    sample_rate = 1
  }
  health_checks    = [google_compute_health_check.frontend.id]
  security_policy  = var.security_policy_id
  session_affinity = "CLIENT_IP"
}

resource "google_compute_backend_service" "frontend_backup" {
  count                 = var.build_backup ? 1 : 0
  name                  = "${var.environment}-backend-service-frontend-backup"
  description           = "Backup backend service for ${var.environment} environment"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = var.backend_port_name

  backend {
    group           = var.instancegroups.ig.backup
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }
  log_config {
    enable      = true
    sample_rate = 1
  }
  health_checks    = [google_compute_health_check.frontend.id]
  security_policy  = var.security_policy_id
  session_affinity = "CLIENT_IP"
}