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

# Custom Firewall Rule to enable SSH access
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = var.labs-vpc
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}
