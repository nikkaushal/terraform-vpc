resource "aws_vpc" "main" {
  cidr_block              = var.VPC_CIDR
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags                    = {
    Name                  = "${var.PROJECT_NAME}-${var.ENV}-vpc"
    Environment           = var.ENV
    Provisioned_by        = "Terraform"
  }
}

resource "aws_subnet" "private-subnets" {
  count                      = 2
  cidr_block                = cidrsubnet(var.VPC_CIDR, 2, count.index)
  vpc_id                    = aws_vpc.main.id
  availability_zone         = element(data.aws_availability_zones.zones.names, count.index)
  tags                      = {
    Name                    = "${var.PROJECT_NAME}-${var.ENV}-private-subnet-${count.index+1}"
    Environment             = var.ENV
    Provisioned_by          = "Terraform"
  }
}

resource "aws_subnet" "public-subnets" {
  count                     = 2
  cidr_block                = cidrsubnet(var.VPC_CIDR, 2, count.index+2)
  vpc_id                    = aws_vpc.main.id
  availability_zone         = element(data.aws_availability_zones.zones.names, count.index)
  tags                      = {
    Name                    = "${var.PROJECT_NAME}-${var.ENV}-public-subnet-${count.index+1}"
    Environment             = var.ENV
    Provisioned_by          = "Terraform"
  }
}