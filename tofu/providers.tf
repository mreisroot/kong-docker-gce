provider "google" {
  credentials = file("~/.creds/labs-compute-dns-admin-key.json")

  project = "labs-22648"
  region  = "us-central1"
  zone    = "us-central1-a"
}
