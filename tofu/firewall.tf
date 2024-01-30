# Custom Firewall Rule to enable SSH access
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.labs_vpc.name
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  direction     = "INGRESS"
  target_tags   = ["allow-ssh"]
}

# Custom Firewall Rule to enable HTTP and HTTPS access
resource "google_compute_firewall" "web" {
  name    = "allow-http-https"
  network = google_compute_network.labs_vpc.name
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  direction     = "INGRESS"
}

# Custom Firewall Rule to open Kong's ports
resource "google_compute_firewall" "kong" {
  name    = "allow-kong"
  network = google_compute_network.labs_vpc.name
  allow {
    ports    = ["8000", "8001", "8002", "8003", "8004", "8443", "8444", "8445"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  direction     = "INGRESS"
}

# Custom Firewall Rule to open PostgreSQL's port
resource "google_compute_firewall" "postgres" {
  name    = "allow-postgres"
  network = google_compute_network.labs_vpc.name
  allow {
    ports    = ["5432"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  direction     = "INGRESS"
}

# Custom Firewall Rule to open Konga's port
resource "google_compute_firewall" "konga" {
  name    = "allow-konga"
  network = google_compute_network.labs_vpc.name
  allow {
    ports    = ["1337"]
    protocol = "tcp"
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  direction     = "INGRESS"
}
