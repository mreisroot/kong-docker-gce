# GCE Instance that will host Kong
resource "google_compute_instance" "kong_instance" {
  name         = "kong-instance"
  machine_type = "n1-standard-1"
  tags         = ["ssh"]

  boot_disk {
    device_name = "kong-instance-disk"
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = "10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.labs_subnet.id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${file("~/.ssh/id_rsa.pub")}"
  }
}
