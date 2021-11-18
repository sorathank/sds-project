resource "aws_security_group" "private_app" {
    vpc_id = aws_vpc.main.id
    name = "private_app"
}

resource "aws_security_group_rule" "private_local_rule" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    self = true
    security_group_id = aws_security_group.private_app.id
}

resource "aws_security_group_rule" "private_ssh_rule" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
    security_group_id = aws_security_group.private_app.id
}

resource "aws_security_group_rule" "private_app_all_rule" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.private_app.id
}

resource "aws_security_group" "private_db" {
    vpc_id = aws_vpc.main.id
    name = "private_db"
}

resource "aws_security_group_rule" "private_db_local_rule" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    security_group_id = aws_security_group.private_db.id
}

resource "aws_security_group_rule" "private_db_all_rule" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.private_db.id
}