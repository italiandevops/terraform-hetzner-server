resource "hcloud_firewall" "firewall01" {
  name = "firewall01"
  # SSH
  rule {
    description = "SSH"
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "XXX.XXX.XXX.XXX"
    ]
  }
  # HTTP
  rule {
    description = "HTTP"
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  # HTTPS
  rule {
    description = "HTTPS"
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_network" "network01" {
  name     = "network01"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "subnet01" {
  type         = "cloud"
  network_id   = hcloud_network.network01.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_server" "server01" {
  name         = "server01"
  server_type  = "cx11"
  image        = "ubuntu-22.04"
  location     = "nbg1"
  ssh_keys     = ["${data.hcloud_ssh_key.ssh_key.id}"]
  firewall_ids = [hcloud_firewall.firewall01.id]

  network {
    network_id = hcloud_network.network01.id
    ip         = "10.0.1.5"
  }

  depends_on = [
    hcloud_network_subnet.subnet01
  ]
}