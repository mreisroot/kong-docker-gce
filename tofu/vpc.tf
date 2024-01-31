# Labs project VPC
resource "google_compute_network" "labs_vpc" {
  name                    = "${var.project-id}-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Labs project Subnet
resource "google_compute_subnetwork" "labs_subnet" {
  name          = "${var.project-id}-subnet"
  network       = google_compute_network.labs_vpc.id
  ip_cidr_range = "10.0.0.0/29"
  region        = var.project-region
}

# Static Public IP Address
resource "google_compute_address" "static" {
  name = "${var.project-id}-ipv4-address"
}
