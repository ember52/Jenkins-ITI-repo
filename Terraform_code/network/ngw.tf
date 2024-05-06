resource "aws_eip" "main_nat_eip" {
  # vpc = true
  domain = "vpc"
  tags = {
    "Name" = "${var.common_resource_name}_EIP"
  }
}

resource "aws_nat_gateway" "main_ngw" {
  allocation_id = aws_eip.main_nat_eip.id
  subnet_id     = aws_subnet.subnets["public1"].id
  tags = {
    Name = "${var.common_resource_name}_NGW"
  }
}