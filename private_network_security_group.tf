resource "aws_security_group" "private-network-sg" {
  name = "private-network-sg"

  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol = -1
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
