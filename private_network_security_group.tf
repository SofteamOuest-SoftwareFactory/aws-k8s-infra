resource "aws_security_group" "private_network_sg" {
  name = "bastion-security-group"

  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol = "tcp"
    from_port = 0
    to_port = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
