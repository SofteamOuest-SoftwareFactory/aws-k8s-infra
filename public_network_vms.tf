resource "aws_instance" "bastion" {
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  associate_public_ip_address = true

  key_name = "${aws_key_pair.bastion-key.key_name}"

  security_groups = [
    "${aws_security_group.bastion-sg.id}",
  ]

  subnet_id = "${aws_subnet.public_subnet.id}"

  provisioner "file" {
    source = "./${aws_key_pair.bastion-key.key_name}.pem"

    destination = "/home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem"

    connection {
      user = "ec2-user"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem",
    ]

    connection {
      user = "ec2-user"
    }
  }

  tags = {
    Name = "bastion"
  }
}