resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_default_vpc.default.id}"
  cidr_block = "172.31.96.0/20"
  availability_zone = "${var.availability_zone}a"

  tags {
    Name = "private subnet"
  }
}

resource "aws_route_table" "private_routetable" {
  vpc_id = "${aws_default_vpc.default.id}"
  tags {
    Name = "private Routetable"
  }
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_routetable.id}"
}


resource "aws_route" "nat_route" {
  route_table_id = "${aws_route_table.private_routetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_nat_gateway.nat.id}"
}


