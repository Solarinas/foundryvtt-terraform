terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.21.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "do_network" {
  source = "./modules/do_network"
}

module "foundryvtt" {
  source = "./applications/foundryvtt"
  prvt_key = var.prvt_key
  pub_key = var.pub_key
}
