resource "aws_key_pair" "bastion-key" {
  key_name = "bastion-key"

  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4A2Iw7nmZVH63ufgRd2w5DS6E4oe6abUJiOi/O1qzb4O20U+G0RKExmjF2dnxbxHCkRFSk/AvRMtXsnoe183x5/Nh8KMgT92FVJ4r7VkZRVbF5CWqCp34iTjgm4p3mZYZOlSPaH7R4yuD0PrZ+LJldqHIsdDb0BbSPDFNxMAuhg945sHRkop2xmNIG88O/cvnC1RVFUf8ZPY+UJLu91ZMe+olVqx5WY/RbsvvJ6qj3ojDuUtIuw+//ejuH9zsljTDxKwYQIKJvUx9FQReTXBtSecUiaeLpn5133TZOxTsD8VAb+2Kz5IberYKofgJxi2luFM3dF8CVa8Uu3uI2oW/ elkouhen@frp02400"
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
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  associate_public_ip_address = true

  key_name = "${aws_key_pair.bastion-key.key_name}"
  security_groups = [
    "${aws_security_group.bastion-sg.id}"]

  subnet_id = "${aws_default_subnet.default.id}"

  provisioner "file" {

    source = "./${aws_key_pair.bastion-key.key_name}.pem"
    destination = "/home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem"

    connection {
      user = "ec2-user"
    }
  }

/*  provisioner "local-exec" {
    command = "chmod 400 /home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem"

    connection {
      user = "ec2-user"
    }
  }*/

}