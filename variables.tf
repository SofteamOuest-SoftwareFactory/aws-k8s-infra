variable availability_zone {
  type = "string"
  default = "us-east-1"
}

variable vm_kind {
  type = "string"
  default = "t2.micro"
}

variable ami_kind {
  type = "string"
  default = "ami-035be7bafff33b6b6"
}

variable public-network-enable {
  default = 1
}

variable public-vm-count {
  default = 1
}

variable private-network-enable {
  default = 1
}

variable private-network-egress-enable {
  default = 1
}

variable private-vm-count {
  default = 1
}

variable private_cidr {
  type = "string"
  default = "172.31.96.0/20"
}

variable public_cidr {
  type = "string"
  default = "172.31.112.0/20"
}