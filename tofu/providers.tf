provider "google" {
  credentials = file("${var.sa-key-path}")

  project = var.project-id
  region  = var.project-region
  zone    = var.project-zone
}
