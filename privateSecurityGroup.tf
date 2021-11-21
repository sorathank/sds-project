resource "aws_security_group" "app_db" {
    vpc_id = aws_vpc.main.id
    name = "app_db"
}

resource "aws_security_group_rule" "private_mariadb_rule" {
    type = "egress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
    security_group_id = aws_security_group.app_db.id
}

// DEBUG
resource "aws_security_group_rule" "private_ssh_rule" {
    type = "egress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
    security_group_id = aws_security_group.app_db.id
}
resource "aws_security_group_rule" "app_db_icmp_in" {
    type = "ingress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.app_db.id
}
resource "aws_security_group_rule" "app_db_icmp_out" {
    type = "egress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.app_db.id
}
resource "aws_security_group_rule" "app_db_all_rule" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.app_db.id
}

resource "aws_security_group" "db_app" {
  name   = "db_app"
  vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "db_app_icmp_in" {
    type = "ingress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.db_app.id
}
resource "aws_security_group_rule" "db_app_icmp_out" {
    type = "egress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.db_app.id
}
resource "aws_security_group_rule" "db_app_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
    security_group_id = aws_security_group.db_app.id
}
resource "aws_security_group_rule" "db_app_con" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
    security_group_id = aws_security_group.db_app.id
}

resource "aws_security_group" "db_ngw" {
    vpc_id = aws_vpc.main.id
    name = "db_ngw"
}
resource "aws_security_group_rule" "db_ngw_icmp_in" {
    type = "ingress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.db_ngw.id
}
resource "aws_security_group_rule" "db_ngw_icmp_out" {
    type = "egress"
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.db_ngw.id
}
resource "aws_security_group_rule" "db_ngw_wildcard" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.db_ngw.id
}