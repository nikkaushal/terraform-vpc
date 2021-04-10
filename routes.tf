resource "aws_route_table" "public" {
  vpc_id             = aws_vpc.main.id

  route {
    cidr_block       = "0.0.0.0/0"
    gateway_id       = aws_internet_gateway.igw.id
  }
  route {
    cidr_block                 = var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  }
  tags               = {
    Name             = "${var.PROJECT_NAME}-${var.ENV}-public-rtable"
    Environment      = var.ENV
    Provisioned_by   = "Terraform"
  }
}

resource "aws_route_table" "private" {
  vpc_id             = aws_vpc.main.id

  route {
    cidr_block       = "0.0.0.0/0"
    nat_gateway_id   = aws_nat_gateway.ngw.id
  }
  route {
    cidr_block                 = var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  }
  tags               = {
    Name             = "${var.PROJECT_NAME}-${var.ENV}-public-rtable"
    Environment      = var.ENV
    Provisioned_by   = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count              = 2
  route_table_id     = aws_route_table.public.id
  subnet_id          = element(aws_subnet.public-subnets.*.id,count.index)

}

resource "aws_route_table_association" "private" {
  count              = 2
  route_table_id     = aws_route_table.private.id
  subnet_id          = element(aws_subnet.private-subnets.*.id,count.index)

}

## Route to default vpc route table

resource "aws_route" "default-rt-route" {
  route_table_id = var.DEFAULT_RT
  destination_cidr_block = aws_vpc.main.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}