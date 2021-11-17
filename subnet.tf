resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "app_db_private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "app_db_subnet"
  }
}

resource "aws_subnet" "db_private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.availability_zone

  tags = {
    "Name" = "db_private_subnet"
  }
}