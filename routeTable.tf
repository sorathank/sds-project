resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "public_route_table"
    }
}

resource "aws_route" "public_igw" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
    route_table_id = aws_route_table.public.id
    subnet_id = aws_subnet.public.id
}

resource "aws_route_table" "db_private" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "db_private"
    }
}

resource "aws_route" "private_ngw" {
    route_table_id = aws_route_table.db_private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "private" {
    route_table_id = aws_route_table.db_private.id
    subnet_id = aws_subnet.db_private.id
}