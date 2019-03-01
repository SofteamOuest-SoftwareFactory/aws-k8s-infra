resource "aws_subnet" "private" {

  availability_zone = "us-east-1a"

  cidr_block = "172.31.96.0/20"

  vpc_id = "${aws_default_vpc.default.id}"



}


resource "aws_instance" "vm" {
  ami = "${var.ami_kind}"

  instance_type = "${var.vm_kind}"

  count = 2

  key_name = "${aws_key_pair.bastion-key.key_name}"

  security_groups = [
    "${aws_security_group.bastion-sg.id}"]

  subnet_id = "${aws_subnet.private.id}"

  provisioner "file" {

    source = "./${aws_key_pair.bastion-key.key_name}.pem"
    destination = "/home/ec2-user/${aws_key_pair.bastion-key.key_name}.pem"

    connection {
      user = "ec2-user"
    }
  }
}
