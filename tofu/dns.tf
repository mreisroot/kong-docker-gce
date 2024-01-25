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
  dns_name = "prod.${random_id.rnd_dns_id.hex}.com."
}

# A Random ID that will be generated for the DNS name
resource "random_id" "rnd_dns_id" {
  byte_length = 4
}
