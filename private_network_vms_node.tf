resource "aws_instance" "node" {
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  key_name = "${aws_key_pair.bastion-key.key_name}"

  count = "${var.private-node-count}"

  security_groups = [
    "${aws_security_group.bastion-sg.id}",
    "${aws_security_group.private_network_sg.id}"
  ]

  subnet_id = "${aws_subnet.private_subnet.id}"

  provisioner "file" {
    source = "~/.ssh/id_rsa"
    destination = "/home/ec2-user/bastion-key.pem"

    connection {

      bastion_host = "${aws_instance.bastion.public_ip}"
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("bastion-key.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/bastion-key.pem"
    ]

    connection {

      bastion_host = "${aws_instance.bastion.public_ip}"
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("bastion-key.pem")}"
    }
  }

  tags = {
    Name = "node"
  }
}

