resource "aws_subnet" "private_subnet" {
  count = "${var.private-network-enable}"

  vpc_id = "${aws_default_vpc.default.id}"

  cidr_block = "${var.private_cidr}"

  availability_zone = "${var.availability_zone}a"

  tags {
    Name = "private subnet"
  }
}

resource "aws_route_table" "private_routetable" {
  count = "${var.private-network-egress-enable}"

  vpc_id = "${aws_default_vpc.default.id}"

  tags {
    Name = "private route-table"
  }
}

resource "aws_route_table_association" "private_subnet" {
  count = "${var.private-network-egress-enable}"

  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_routetable.id}"
}

resource "aws_route" "nat_route" {
  count = "${var.private-network-egress-enable}"

  route_table_id = "${aws_route_table.private_routetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_nat_gateway.nat.id}"
}
