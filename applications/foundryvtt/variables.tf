variable prvt_key {}

variable pub_key {}

variable vpc_id {}

variable image {
  type = string
  default = "rockylinux-9-x64"
}

variable region {
  default = "tor1"
}

variable size {
  default = "s-1vcpu-1gb"
}
