provider "google" {
  credentials = file("~/.creds/labs-terraform-key.json")

  project = "labs-22648"
  region  = "us-central1"
  zone    = "us-central1-a"
}
