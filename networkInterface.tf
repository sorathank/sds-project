resource "aws_network_interface" "app_public" {
  subnet_id       = aws_subnet.app_public.id
  # security_groups = [aws_security_group.web.id]
  tags = {
    Name = "app_public_network_interface"
  }
}

resource "aws_network_interface" "app_private" {
  subnet_id       = aws_subnet.app_db_private.id
  # security_groups = [aws_security_group.web.id]

  tags = {
    Name = "app_private_network_interface"
  }
}

resource "aws_network_interface" "db_app_private" {
  subnet_id       = aws_subnet.app_db_private.id
  # security_groups = [aws_security_group.web.id]

  tags = {
    Name = "db_to_app_network_interface"
  }
}

resource "aws_network_interface" "db_private" {
  subnet_id       = aws_subnet.db_private.id
  # security_groups = [aws_security_group.web.id]

  tags = {
    Name = "db_private_network_interface"
  }
}