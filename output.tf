output "vpc-id" {
  value = "${aws_vpc.vpc-devops.id}"
}

output "private-subnets" {
  value = [
    "${aws_subnet.subnet-private-1.id}",
    "${aws_subnet.subnet-private-2.id}",
  ]
}

output "public-subnets" {
  value = [
    "${aws_subnet.subnet-public-1.id}",
    "${aws_subnet.subnet-public-2.id}",
  ]
}

output "availability-zones" {
  value = "${data.aws_availability_zones.available.names}"
}
