provider "aws" {

  region = "us-east-1"
}

resource "aws_default_vpc" "default" {

}

resource "aws_default_subnet" "default" {

  availability_zone = "us-east-1a"
}

/*
resource "aws_internet_gateway" "default" {

}*/
