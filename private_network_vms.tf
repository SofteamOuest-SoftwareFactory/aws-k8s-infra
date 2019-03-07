resource "aws_instance" "vm" {
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  associate_public_ip_address = false

  key_name = "${aws_key_pair.bastion-key.key_name}"

  security_groups = [
    "${aws_security_group.bastion-sg.id}",
  ]

  subnet_id = "${aws_subnet.private_subnet.id}"

  tags = {
    Name = "vm"
  }
}