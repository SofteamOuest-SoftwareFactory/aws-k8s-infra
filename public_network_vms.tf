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
    source = "~/.ssh/id_rsa"
    destination = "/home/ec2-user/bastion-key.pem"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("bastion-key.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/bastion-key.pem",
      "sudo yum install -y python-pip git",
      "sudo pip install ansible boto",
      "sudo mkdir /etc/ansible",
      "sudo wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -O /etc/ansible/hosts",
      "sudo chmod ugo+rx /etc/ansible/hosts",
      "sudo wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini -O /etc/ansible/ec2.ini",
      "git clone https://github.com/SofteamOuest-SoftwareFactory/software-factory.git"

    ]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("bastion-key.pem")}"
    }
  }

  tags = {
    Name = "bastion"
  }
}
