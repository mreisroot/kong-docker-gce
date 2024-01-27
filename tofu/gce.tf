# GCE Instance that will host Kong
resource "google_compute_instance" "kong_instance" {
  name         = "kong-instance"
  machine_type = "n1-standard-1"
  tags         = ["allow-ssh", "allow-web", "allow-kong", "allow-db"]

  # Instance disk configuration
  boot_disk {
    device_name = "kong-instance-disk"
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = "10"
    }
  }

  # Instance networking
  network_interface {
    subnetwork = google_compute_subnetwork.labs_subnet.id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  # SSH key configuration
  metadata = {
    ssh-keys = "${var.ssh-user}:${file("~/.ssh/id_rsa.pub")}"
  }

  # Provision the instance with Ansible
  provisioner "local-exec" {
    command = "ansible-playbook -u ${var.ssh-user} -i ../ansible/inventory.gcp.yml ../ansible/playbook.yml"
  }
}
