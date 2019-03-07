resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_default_vpc.default.id}"
  cidr_block = "172.31.112.0/20"
  availability_zone = "${var.availability_zone}a"

  tags {
    Name = "public subnet"
  }
}