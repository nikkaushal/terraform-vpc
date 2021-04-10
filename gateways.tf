resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags              = {
    Name            = "${var.PROJECT_NAME}-${var.ENV}-igw"
    Environment     = var.ENV
    Provisioned_by  = "Terraform"
  }
}

resource "aws_eip" "ngw" {
  vpc =              true
  tags              = {
    Name            = "${var.PROJECT_NAME}-${var.ENV}-ngw-ip"
    Environment     = var.ENV
    Provisioned_by  = "Terraform"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id      = aws_eip.ngw.id
  subnet_id          = aws_subnet.public-subnets.*.id[0]
  tags               = {
    Name             = "${var.PROJECT_NAME}-${var.ENV}-ngw"
    Environment      = var.ENV
    Provisioned_by   = "Terraform"
  }
}

