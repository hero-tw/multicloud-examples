data "aws_availability_zones" "available" {}

resource "aws_default_vpc" "kube" {
  tags = "${
	map(
	 "Name", "${var.env_name}-vpc",
	 "kubernetes.io/cluster/${var.env_name}", "shared"
	)
  }"
}

resource "aws_default_subnet" "kube" {
  availability_zone = "${var.aws_region_storage}"

  tags = "${
	map(
	 "Name", "${var.env_name}-subnet",
	 "kubernetes.io/cluster/${var.env_name}", "shared"
	)
  }"
}

/*
resource "aws_internet_gateway" "kube" {
  vpc_id = "${aws_default_vpc.kube.id}"

  tags {
    Name = "${var.env_name}-gateway"
  }
}

resource "aws_route_table" "kube" {
  vpc_id = "${aws_default_vpc.kube.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kube.id}"
  }
}

resource "aws_route_table_association" "kube" {
  count = 2

  subnet_id      = "${aws_default_subnet.kube.*.id[count.index]}"
  route_table_id = "${aws_route_table.kube.id}"
}
*/
