resource "aws_network_interface" "app_igw" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.public.id]
  tags = {
    Name = "app_public_network_interface"
  }
}

resource "aws_network_interface" "app_db" {
  subnet_id       = aws_subnet.app_db_private.id
  security_groups = [aws_security_group.app_db.id]
  private_ips = ["10.0.2.100"]
  tags = {
    Name = "app_private_network_interface"
  }
}

resource "aws_network_interface" "db_app" {
  subnet_id       = aws_subnet.app_db_private.id
  security_groups = [aws_security_group.db_app.id]
  private_ips = ["10.0.2.101"]
  tags = {
    Name = "db_to_app_network_interface"
  }
}

resource "aws_network_interface" "db_ngw" {
  subnet_id       = aws_subnet.db_private.id
  security_groups = [aws_security_group.db_ngw.id]

  tags = {
    Name = "db_ngw_network_interface"
  }
}
