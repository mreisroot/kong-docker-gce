# The DNS Record Set for Kong
resource "google_dns_record_set" "kong_instance" {
  name = "kong.${google_dns_managed_zone.prod.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.prod.name
  rrdatas      = [google_compute_instance.kong_instance.network_interface[0].access_config[0].nat_ip]
}

# Managed DNS Zone that will be used
resource "google_dns_managed_zone" "prod" {
  name     = "prod-zone"
  dns_name = "prod.${random_id.rnd.hex}.com."
}

# A Random ID that will be generated
resource "random_id" "rnd" {
  byte_length = 4
}
