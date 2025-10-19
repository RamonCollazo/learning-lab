resource "aws_eip" "devops-eip" {
  domain = "vpc"
  
  tags = {
    Name = "devops-eip"
  }
}
