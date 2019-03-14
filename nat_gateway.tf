resource "aws_eip" "nat_eip" {

  count = "${var.private-network-egress-enable}"

  vpc = true
}

resource "aws_nat_gateway" "nat" {

  count = "${var.private-network-egress-enable}"

  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
}