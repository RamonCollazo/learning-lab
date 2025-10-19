resource "aws_security_group" "example-sg" {
  name        = "example-sg"
  description = "Security group example"
}

resource "aws_vpc_security_group_ingress_rule" "example-sg-http" {
  security_group_id = aws_security_group.example-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "http"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "example-sg-ssh" {
  security_group_id = aws_security_group.example-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}
