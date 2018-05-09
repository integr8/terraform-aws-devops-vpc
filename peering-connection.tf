# resource "aws_vpc_peering_connection" "foo" {
#   peer_owner_id = "${var.peer_owner_id}"
#   peer_vpc_id   = "${aws_vpc.bar.id}"
#   vpc_id        = "${aws_vpc.foo.id}"
#   peer_region   = "us-east-1"
# }

