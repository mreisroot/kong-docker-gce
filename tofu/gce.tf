# GCE Instance that will host Kong
resource "google_compute_instance" "kong_instance" {
  name                      = "kong-instance"
  machine_type              = "e2-small"
  tags                      = ["allow-ssh", "allow-web", "allow-kong", "allow-konga", "allow-db", "http-server", "https-server"]
  allow_stopping_for_update = true

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
    inline = ["echo \"SSH Connection is HEALTHY!\""]

    connection {
      host        = google_compute_address.static.address
      type        = "ssh"
      user        = var.ssh-user
      private_key = file("~/.ssh/id_rsa")
    }
  }

  # Provision the instance with Ansible
  provisioner "local-exec" {
    command     = <<EOF
    ssh-keyscan -H ${google_compute_address.static.address} >> ~/.ssh/known_hosts 
    #sed -i "s|your_project_id|\${var.project-id}|g" ../ansible/inventory.gcp.yml
    #sed -i "s|service_account_key_path|\${var.sa-key-path}|g" ../ansible/inventory.gcp.yml
    ansible-playbook -u ${var.ssh-user} -i ../ansible/inventory.gcp.yml ../ansible/playbook.yml
    EOF
    interpreter = ["/bin/bash", "-c"]
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
