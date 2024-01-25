# Custom Firewall Rule to enable SSH access
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = var.labs-vpc
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  target_tags = ["ssh"]
}

# Custom Firewall Rule to enable HTTP and HTTPS access
resource "google_compute_firewall" "web" {
  name    = "allow-http-https"
  network = var.labs-vpc
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
}

# Custom Firewall Rule to open Kong's ports
resource "google_compute_firewall" "kong" {
  name    = "allow-kong"
  network = var.labs-vpc
  allow {
    ports    = ["8000", "8001", "8002", "8003", "8004", "8443", "8444", "8445"]
    protocol = "tcp"
  }
}

# Custom Firewall Rule to open PostgreSQL's port
resource "google_compute_firewall" "postgres" {
  name    = "allow-postgres"
  network = var.labs-vpc
  allow {
    ports    = ["5432"]
    protocol = "tcp"
  }
}

# Custom Firewall Rule to open Konga's port
resource "google_compute_firewall" "konga" {
  name    = "allow-konga"
  network = var.labs-vpc
  allow {
    ports    = ["1337"]
    protocol = "tcp"
  }
}
