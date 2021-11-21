resource "aws_eip" "public_ip" {
    vpc = true
    depends_on = [
        aws_internet_gateway.igw
    ]
    network_interface = aws_network_interface.app_igw.id
}

resource "aws_eip" "ngw" {
  vpc = true

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_key_pair" "key" {
    key_name = "db_instance_key"
    public_key = var.PUBLIC_KEY_SSH
}