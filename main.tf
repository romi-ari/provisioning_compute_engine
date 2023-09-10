resource "google_compute_address" "terraria-static-ip" {
    name = "terraria-static-ip"
    region = "asia-southeast2"
}

resource "google_compute_instance" "default" {
    name                        = "terraria-instance"
    machine_type                = "n2-standard-2"
    zone                        = "asia-southeast2-a"
    tags                        = ["terraria"]
    allow_stopping_for_update   = true

    boot_disk {
        initialize_params {
            image   = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.terraria-static-ip.address
        }
    }
}

resource "google_compute_firewall" "terraria-firewall" {
  name    = "terraria-firewall"
  network = "default"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["7777"]
  }

  source_tags = ["terraria"]
}

