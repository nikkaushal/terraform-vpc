data "aws_availability_zones" "zones" {}

data "aws_route53_zone" "zone" {
  name ="devopsnik.tk"
}