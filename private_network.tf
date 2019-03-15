resource "aws_subnet" "private_subnet" {
  count = "${var.private-network-enable}"

  vpc_id = "${aws_default_vpc.default.id}"

  cidr_block = "${var.private_cidr}"

  availability_zone = "${var.availability_zone}a"

  tags {
    Name = "private aws_subnet"
  }
}

resource "aws_route_table" "private_routetable" {
  count = "${var.private-network-egress-enable}"

  vpc_id = "${aws_default_vpc.default.id}"

  tags {
    Name = "private aws_route_table"
  }
}

resource "aws_route_table_association" "private_subnet" {
  count = "${var.private-network-egress-enable}"

  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_routetable.id}"

}

// aws_route.nat_route: Error: more than 1 target specified. Only 1 of gateway_id, egress_only_gateway_id, nat_gateway_id, instance_id, network_interface_id or vpc_peering_connection_id is allowed.
resource "aws_route" "nat_route" {
  count = "${var.private-network-egress-enable}"

  route_table_id = "${aws_route_table.private_routetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_nat_gateway.nat.id}"

}
