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

module "foundryvtt" {
  source = "./applications/foundryvtt"
  prvt_key = var.prvt_key
  pub_key = var.pub_key
}
