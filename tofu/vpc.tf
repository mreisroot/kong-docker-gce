# Labs project VPC
resource "google_compute_network" "labs_vpc" {
  name                    = "labs-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Labs project Subnet
resource "google_compute_subnetwork" "labs_subnet" {
  name          = "labs-subnet"
  network       = var.labs-vpc
  ip_cidr_range = "10.0.0.0/29"
  region        = "us-central1"
}

# Static Public IP Address
resource "google_compute_address" "static" {
  name = "ipv4-address"
}
