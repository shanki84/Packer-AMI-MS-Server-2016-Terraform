#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table


resource "aws_vpc" "ec2" {
  cidr_block = "${var.cidr-vpc}"
  enable_dns_hostnames = true

  tags = "${
    map(
      "Name", "${var.env}-VPC",
    )
  }"
}

resource "aws_subnet" "ec2" {
  count = 3

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${var.cidr-subnet}.${count.index*64}/26"
  vpc_id            = "${aws_vpc.ec2.id}"
  map_public_ip_on_launch = "false" //it makes this a private subnet

  tags = "${
    map(
      "Name", "${var.env}-Private-Subnet-0${count.index+1}"
    )
  }"
}

resource "aws_internet_gateway" "ec2" {
  vpc_id = "${aws_vpc.ec2.id}"

  tags = {
    Name = "${var.env}-IGW"
  }
}

resource "aws_route_table" "ec2" {
  vpc_id = "${aws_vpc.ec2.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ec2.id}"
  }
}

resource "aws_route_table_association" "ec2" {
  count = 3

  subnet_id      = "${aws_subnet.demo.*.id[count.index]}"
  route_table_id = "${aws_route_table.ec2.id}"

}