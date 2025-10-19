resource "aws_vpc" "example-vpc" {
  cidr_block       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block  = true

  tags = {
    Name = "example-vpc"
  }
}
