terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

locals {
  droplet_name = "foundryvtt-${terraform.workspace}"
}

data "digitalocean_ssh_key" "dmurray" {
  name = "dmurray"
}

resource "digitalocean_droplet" "foundryvtt" {
  image = var.image
  name = local.droplet_name
  region = var.region
  size = var.size
  vpc_uuid = var.vpc_id

  ssh_keys = [
    data.digitalocean_ssh_key.dmurray.id
  ]

  user_data = templatefile("./applications/foundryvtt/foundryvtt.tftpl",
    {
      pub_key = file(var.pub_key)
    })

  tags = [
    "foundryvtt",
  ]
}
