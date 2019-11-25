resource "google_compute_backend_bucket" "static" {
  name        = "${var.name}-backend-bucket"
  bucket_name = "${google_storage_bucket.storage.name}"
  enable_cdn  = true
}

resource "google_compute_global_address" "default" {
  name         = "${var.name}-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_url_map" "urlmap" {
  name        = "${var.name}-url-map"
  description = "URL map for ${var.name}"

  default_service = "${google_compute_backend_bucket.static.self_link}"

  host_rule {
    hosts        = ["paulvarache.co.uk"]
    path_matcher = "main"
  }

  path_matcher {
    name            = "main"
    default_service = "${google_compute_backend_bucket.static.self_link}"
  }
}

resource "google_compute_target_http_proxy" "http" {
  name    = "${var.name}-http-proxy"
  url_map = "${google_compute_url_map.urlmap.self_link}"
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.name}-http-rule"
  target     = "${google_compute_target_http_proxy.http.self_link}"
  ip_address = "${google_compute_global_address.default.address}"
  port_range = "80"
}

resource "google_compute_managed_ssl_certificate" "default" {
  provider = "google-beta"
  name = "${var.name}-cert"

  managed {
    domains = ["paulvarache.co.uk"]
  }
}

resource "google_compute_target_https_proxy" "https" {
  name             = "${var.name}-http-proxy"
  project          = "${var.project}"
  url_map          = "${google_compute_url_map.urlmap.self_link}"
  ssl_certificates = ["${google_compute_managed_ssl_certificate.default.self_link}"]
}

resource "google_compute_global_forwarding_rule" "https" {
  name       = "${var.name}-https-rule"
  project    = "${var.project}"
  target     = "${google_compute_target_https_proxy.https.self_link}"
  ip_address = "${google_compute_global_address.default.address}"
  port_range = "443"
}