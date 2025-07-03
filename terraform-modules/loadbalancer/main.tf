## URL map, a.k.a. Load Balancer

# HTTPS
resource "google_compute_url_map" "load_balancer_https" {
  name            = "${var.environment}-load-balancer-https"
  default_service = google_compute_backend_service.frontend.self_link

  // redirect API traffic to the API backend
  host_rule {
    hosts = [
      var.api_url
    ]
    path_matcher = "api-path-matcher"
  }
  path_matcher {
    name            = "api-path-matcher"
    default_service = google_compute_backend_service.backend.self_link
  }

  // redirect https://<ip address> to https://<base url>
  host_rule {
    hosts = [
      google_compute_global_address.loadbalancer.address
    ]
    path_matcher = "baseurl-paths"
  }
  path_matcher {
    name            = "baseurl-paths"
    default_service = google_compute_backend_service.frontend.self_link
    path_rule {
      paths = ["/"]
      url_redirect {
        https_redirect         = true
        host_redirect          = var.base_url
        redirect_response_code = "PERMANENT_REDIRECT"
        strip_query            = true
      }
    }
  }
}
# HTTP redirect to HTTPS
resource "google_compute_url_map" "load_balancer_http" {
  name            = "${var.environment}-load-balancer-http"
  default_service = google_compute_backend_service.frontend.self_link

  // redirect http://<base url> and http://<ip address> to https://<base url>
  host_rule {
    hosts = [
      var.base_url,
      google_compute_global_address.loadbalancer.address
    ]
    path_matcher = "baseurl-paths"
  }
  path_matcher {
    name            = "baseurl-paths"
    default_service = google_compute_backend_service.frontend.self_link
    path_rule {
      paths = ["/"]
      url_redirect {
        https_redirect         = true
        host_redirect          = var.base_url
        redirect_response_code = "PERMANENT_REDIRECT"
        strip_query            = true
      }
    }
  }

  // redirect http://<api url> to https://<api url>
  host_rule {
    hosts = [
      var.api_url
    ]
    path_matcher = "api-path-matcher"
  }
  path_matcher {
    name            = "api-path-matcher"
    default_service = google_compute_backend_service.backend.self_link
    path_rule {
      paths = ["/"]
      url_redirect {
        https_redirect         = true
        host_redirect          = var.api_url
        redirect_response_code = "PERMANENT_REDIRECT"
        strip_query            = true
      }
    }
  }
}

## Target proxy
# HTTPS
resource "google_compute_target_https_proxy" "default" {
  name             = "${var.environment}-target-https-proxy"
  url_map          = google_compute_url_map.load_balancer_https.self_link
  ssl_certificates = [google_compute_ssl_certificate.default.self_link]
  ssl_policy       = google_compute_ssl_policy.default.self_link
}
# HTTP
resource "google_compute_target_http_proxy" "default" {
  name    = "${var.environment}-target-http-proxy"
  url_map = google_compute_url_map.load_balancer_http.self_link
}

## Forwarding rules, a.k.a. Frontend
# HTTPS
resource "google_compute_global_forwarding_rule" "frontend_https" {
  name                  = "${var.environment}-frontend-https"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.self_link
  ip_address            = google_compute_global_address.loadbalancer.self_link
  depends_on            = [google_compute_subnetwork.main_proxyonly_subnet]
}
# HTTP
resource "google_compute_global_forwarding_rule" "frontend_http" {
  name                  = "${var.environment}-frontend-http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.self_link
  ip_address            = google_compute_global_address.loadbalancer.self_link
  depends_on            = [google_compute_subnetwork.main_proxyonly_subnet]
}