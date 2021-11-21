resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = "app_igw"
    }
}

resource "aws_nat_gateway" "ngw" {
    connectivity_type = "public"
    allocation_id = aws_eip.ngw.id
    subnet_id = aws_subnet.public.id
    
    depends_on = [
        aws_internet_gateway.igw
    ]
    tags = {
        "Name" : "app_ngw"
    }
}