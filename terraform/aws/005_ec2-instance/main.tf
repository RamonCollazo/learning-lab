# Instance
resource "aws_instance" "example-ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"

  key_name      = aws_key_pair.example-kp.id

  vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  tags = {
    Name = "example-ec2"
  }
}

# Key
resource "aws_key_pair" "example-kp" {
  key_name   = "example-kp"
  public_key = tls_private_key.example-kp.public_key_openssh
}

resource "tls_private_key" "example-kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Security group
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}
