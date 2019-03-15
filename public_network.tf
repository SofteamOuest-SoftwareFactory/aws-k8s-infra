resource "aws_subnet" "public_subnet" {
  count = "${var.public-network-enable}"

  vpc_id            = "${aws_default_vpc.default.id}"
  cidr_block        = "${var.public_cidr}"
  availability_zone = "${var.availability_zone}a"

  tags {
    Name = "public aws_subnet"
  }
}
