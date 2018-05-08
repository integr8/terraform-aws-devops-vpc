### VPC
resource "aws_vpc" "vpc-devops" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "vpc-devops"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = "${aws_vpc.vpc-devops.id}"

  tags {
    Name = "internet-gateway"
  }
}

## Route Tables

# Private/Default
resource "aws_default_route_table" "rt_private" {
  default_route_table_id = "${aws_vpc.vpc-devops.default_route_table_id}"

  tags {
    Name = "rt_private"
  }
}

# Public/Internet
resource "aws_route_table" "rt_public" {
  vpc_id = "${aws_vpc.vpc-devops.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet-gateway.id}"
  }

  tags {
    Name = "rt_public"
  }
}

## Subnets

# Public
resource "aws_subnet" "subnet-public-1" {
  vpc_id                  = "${aws_vpc.vpc-devops.id}"
  cidr_block              = "${element(var.subnets["public"], 0)}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "subnet-public-1"
  }
}

resource "aws_subnet" "subnet-public-2" {
  vpc_id                  = "${aws_vpc.vpc-devops.id}"
  cidr_block              = "${element(var.subnets["public"], 1)}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "subnet-public-2"
  }
}

# Private
resource "aws_subnet" "subnet-private-1" {
  vpc_id                  = "${aws_vpc.vpc-devops.id}"
  cidr_block              = "${element(var.subnets["private"], 0)}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "subnet-private-1"
  }
}

resource "aws_subnet" "subnet-private-2" {
  vpc_id                  = "${aws_vpc.vpc-devops.id}"
  cidr_block              = "${element(var.subnets["private"], 1)}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "subnet-private-2"
  }
}

# Subnet Associations
resource "aws_route_table_association" "subnet-public-1-x-rt-public" {
  subnet_id      = "${aws_subnet.subnet-public-1.id}"
  route_table_id = "${aws_route_table.rt_public.id}"
}

resource "aws_route_table_association" "subnet-public-2-x-rt-public" {
  subnet_id      = "${aws_subnet.subnet-public-2.id}"
  route_table_id = "${aws_route_table.rt_public.id}"
}

resource "aws_route_table_association" "subnet-private-1-x-rt-private" {
  subnet_id      = "${aws_subnet.subnet-private-1.id}"
  route_table_id = "${aws_default_route_table.rt_private.id}"
}

resource "aws_route_table_association" "subnet-private-2-x-rt-private" {
  subnet_id      = "${aws_subnet.subnet-private-2.id}"
  route_table_id = "${aws_default_route_table.rt_private.id}"
}
