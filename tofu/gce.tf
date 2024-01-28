# GCE Instance that will host Kong
resource "google_compute_instance" "kong_instance" {
  name         = "kong-instance"
  machine_type = "f1-micro"
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

  # Install Ansible on the instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y python3 python3-pip",
      "sudo pip3 install ansible"
    ]

    connection {
      host        = google_compute_instance.kong_instance.network_interface.0.access_config.0.nat_ip
      type        = "ssh"
      user        = var.ssh-user
      private_key = file("~/.ssh/id_rsa")
    }
  }

  # Provision the instance with Ansible
  provisioner "local-exec" {
    command = <<EOF
    ssh-keyscan -H ${google_compute_address.static.address} >> ~/.ssh/known_hosts
    ansible-playbook -u ${var.ssh-user} -i ../ansible/inventory.gcp.yml ../ansible/playbook.yml
    EOF
  }
}

/*
# Provision the instance using Ansible without installing Ansible on the instance (WIP)
resource "null_resource" "ansible_playbook" {
  depends_on = [google_compute_instance.kong_instance]

  provisioner "local-exec" {
    command = <<EOF
    ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -u ${var.ssh-user} -i ../ansible/inventory.gcp.yml ../ansible/playbook.yml
    EOF
  }
} */
