resource "aws_eip" "example-eip" {
  domain = "vpc"
  
  tags = {
    Name = "example-eip"
  }
}
