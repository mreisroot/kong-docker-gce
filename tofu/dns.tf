# DNS for the GCE instance (WIP)
/*
# Backend Service for Konga container
resource "google_compute_backend_service" "konga_backend" {
  name          = "konga-backend-service"
  health_checks = [google_compute_health_check.konga_health_check.id]
  backend {
    group = google_compute_target_instance.konga_target.self_link
  }
}

resource "google_compute_target_instance" "konga_target" {
  name     = "konga-target"
  instance = google_compute_instance.kong_instance.id
}

# Health Check for Konga container (port 1337)
resource "google_compute_health_check" "konga_health_check" {
  name               = "konga-health-check"
  check_interval_sec = 1
  timeout_sec        = 1

  http_health_check {
    port = 1337
  }
}

# Forwarding Rule for Konga traffic (port 1337)
resource "google_compute_forwarding_rule" "konga_frontend" {
  name            = "konga-forwarding-rule"
  region          = "us-central1"
  ip_address      = google_compute_address.static.address
  port_range      = "1337-1337"
  backend_service = google_compute_backend_service.konga_backend.self_link
}

# The DNS Record Set for Konga
resource "google_dns_record_set" "konga_dns" {
  name = google_dns_managed_zone.prod.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.prod.name
  rrdatas      = [google_compute_forwarding_rule.konga_frontend.ip_address]
}

# Managed DNS Zone that will be used
resource "google_dns_managed_zone" "prod" {
  name     = "prod-zone"
  dns_name = "prod.${random_id.rnd_dns_id.hex}.com."
}

# A Random ID that will be generated for the DNS name
resource "random_id" "rnd_dns_id" {
  byte_length = 4
} */
