# EC2 instance
resource "aws_instance" "example-ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  tags = {
    Name = "example-ec2"
  }
}

# AMI
resource "aws_ami_from_instance" "example-ec2-ami" {
  name                = "example-ec2-ami"
  source_instance_id  = aws_instance.example-ec2.id
}
