terraform {
  cloud {
    organization = "solar-solutions"  
    workspaces {
      tags = [ "foundryvtt" ]
    }
  }
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.28.0"
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

  vpc_id = module.do_network.vpc_uuid

  prvt_key = var.prvt_key
  pub_key = var.pub_key
}
