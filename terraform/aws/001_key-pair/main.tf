resource "tls_private_key" "example-kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example-kp" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.example-kp.public_key_openssh
}

resource "local_file" "example-kp" {
  content  = tls_private_key.example-kp.private_key_pem
  filename = "../example-kp.pem"
  file_permission = "0400"
}
