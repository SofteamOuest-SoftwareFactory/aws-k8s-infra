resource "aws_instance" "bastion" {
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  key_name = "${aws_key_pair.bastion-key.key_name}"

  count = "${var.public-vm-count}"

  security_groups = [
    "${aws_security_group.bastion-sg.id}",
  ]

  subnet_id = "${aws_subnet.public_subnet.id}"

  associate_public_ip_address = true


  provisioner "file" {
    content = "${aws_key_pair.bastion-key.public_key}"
    destination = "/home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }


  provisioner "remote-exec" {

    inline = [
      "chmod 400 /home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem",
      "sudo yum install -y python-pip",
      "sudo pip install ansible boto",
      "wget "
    ]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

  tags = {
    Name = "bastion"
  }
}
