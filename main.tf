provider "aws" {
  region = "${var.availability_zone}"
}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default" {
  availability_zone = "${var.availability_zone}"
}