terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

locals {
  vpc_name = "foundryvtt-vpc"
}

resource "digitalocean_vpc" "foundryvtt_vpc" {
  name = local.vpc_name
  region = var.region
  ip_range = "10.23.1.0/24"
}

# Create DigitalOcean tags
resource "digitalocean_tag" "foundryvtt_tag" {
  name = "foundryvtt"
}

resource "digitalocean_firewall" "foundryvtt_firewall" {
  name = "Foundry"
  depends_on = [
    digitalocean_tag.foundryvtt_tag
  ]

  tags = [ "foundryvtt" ]

  # allow ssh from any connection
  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  # allow outbound tcp connections
  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
