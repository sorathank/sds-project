resource "aws_security_group" "public" {
    vpc_id = aws_vpc.main.id
    name = "public"
}

resource "aws_security_group_rule" "public_local_rule" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "all"
    self = true
    security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_http_rule" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_https_rule" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_ssh_rule" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_icmp_in_rule" {
    type = "ingress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = [ "10.0.0.0/16" ]
    security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_all_rule" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.public.id
}
resource "aws_security_group_rule" "public_icmp_out_rule" {
    type = "egress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = [ "10.0.0.0/16" ]
    security_group_id = aws_security_group.public.id
}
