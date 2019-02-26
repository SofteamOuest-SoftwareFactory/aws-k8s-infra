provider "aws" {

  region = "us-east-1"
}

variable vm_type {
  type = "string"
  default = "t2.micro"
}

resource "aws_default_vpc" "default" {

}

resource "aws_default_subnet" "default" {

  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private" {

  availability_zone = "us-east-1a"
  cidr_block = "172.31.96.0/20"
  vpc_id = "${aws_default_vpc.default.id}"
}

resource "aws_key_pair" "bastion_key" {
  key_name = "elkouhen_key"
  public_key = "COPY KEY HERE"
}

resource "aws_security_group" "bastion-sg" {
  name = "bastion-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami = "ami-035be7bafff33b6b6"
  instance_type = "${var.vm_type}"

  associate_public_ip_address = true

  key_name = "${aws_key_pair.bastion_key.key_name}"
  security_groups = [
    "${aws_security_group.bastion-sg.id}"]

  subnet_id = "${aws_default_subnet.default.id}"
}

resource "aws_instance" "vm1" {
  ami = "ami-035be7bafff33b6b6"
  instance_type = "${var.vm_type}"

  key_name = "${aws_key_pair.bastion_key.key_name}"
  security_groups = [
    "${aws_security_group.bastion-sg.id}"]

  subnet_id = "${aws_subnet.private.id}"
}

