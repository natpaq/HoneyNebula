provider "google" {
  credentials = file("account.json")
  project     = "project-ID"
  region      = "northamerica-northeast1"
  zone        = "northamerica-northeast1-c"
}


########################################################################
#                              Networking                              #
########################################################################
#resource "google_compute_network" "default" {
#  name = "honeynetwork"
#}

#resource "google_compute_subnetwork" "default" {
#  name          = "honeysubnet"
#  ip_cidr_range = "10.0.0.0/16"
#  region        = "northamerica-northeast1"
#  network       = google_compute_network.default
#}
#
#resource "google_compute_subnetwork" "subnet-us-ce" {
#	
#}
#
#resource "google_compute_network" "subnet-eu" {
#	
#}
#
########################################################################
#                              Instances                               #
########################################################################

resource "google_compute_instance" "honeycore" {
  name         = "honeycore"
  machine_type = "n1-standard-2"
  zone         = "northamerica-northeast1-c"

  boot_disk {
    initialize_params {
      size  = 128
      image = "debian-cloud/debian-10"
    }
  }

  metadata = {
    ssh-keys = "tpotter:${file("~/.ssh/honeypot.pub")}"
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP <EMPTY>
    }
  }

  provisioner "file" {
    source      = "../tpot_setup"
    destination = "/home/tpotter"

    connection {
      type        = "ssh"
      user        = "tpotter"
      private_key = file("~/.ssh/honeypot")
      host        = google_compute_instance.honeycore.network_interface.0.access_config.0.nat_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt install git -y",
      "git clone https://github.com/dtag-dev-sec/tpotce tpotce",
      "sudo /home/tpotter/tpotce/iso/installer/install.sh --type=auto --conf=/home/tpotter/tpot_setup/tpot.conf",
      "sudo cp /home/tpotter/tpot_setup/logstash.conf /data/elk/logstash.conf",
      "sudo sed -i 's/elasticsearch:9200/localhost:64298/g' /data/elk/logstash.conf",
      "sudo chown tpot:tpot /data/elk/logstash.conf",
      "sudo cp /home/tpotter/tpot_setup/tpot.yml /opt/tpot/etc/compose/standard.yml",
      "sudo shutdown -r"
    ]

    connection {
      type        = "ssh"
      user        = "tpotter"
      private_key = file("~/.ssh/honeypot")
      host        = self.network_interface.0.access_config.0.nat_ip
      #google_compute_instance.honeycore.network_interface.0.access_config.0.nat_ip
    }
  }
}

resource "google_compute_instance" "honeypot" {
  for_each = var.honeypot_regionmap

  name         = each.key
  machine_type = "n1-standard-2"
  zone         = each.value

  boot_disk {
    initialize_params {
      size  = 128
      image = "debian-cloud/debian-10"
    }
  }

  metadata = {
    user-data = file("../cloud-init.yaml")
    ssh-keys  = "tpotter:${file("~/.ssh/honeypot.pub")}"
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP <EMPTY>
    }
  }

  provisioner "file" {
    source      = "../tpot_setup"
    destination = "/home/tpotter"

    connection {
      type        = "ssh"
      user        = "tpotter"
      private_key = file("~/.ssh/honeypot")
      host        = self.network_interface.0.access_config.0.nat_ip
      #google_compute_instance.honeypot["honeypot-{each.key}"].network_interface.0.access_config.0.nat_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt install git -y",
      "git clone https://github.com/dtag-dev-sec/tpotce tpotce",
      "sudo /home/tpotter/tpotce/iso/installer/install.sh --type=auto --conf=/home/tpotter/tpot_setup/tpot.conf",
      "sudo cp /home/tpotter/tpot_setup/logstash.conf /data/elk/logstash.conf",
      "sudo sed -i 's/elasticsearch:9200/${google_compute_instance.honeycore.network_interface.0.network_ip}:64298/g' /data/elk/logstash.conf",
      "sudo cp /home/tpotter/tpot_setup/tpot.yml /opt/tpot/etc/compose/standard.yml",
      "sudo shutdown -r"
    ]

    connection {
      type        = "ssh"
      user        = "tpotter"
      private_key = file("~/.ssh/honeypot")
      host        = self.network_interface.0.access_config.0.nat_ip
      #google_compute_instance.honeypot["honeypot-{each.key}"].network_interface.0.access_config.0.nat_ip
    }
  }
}
