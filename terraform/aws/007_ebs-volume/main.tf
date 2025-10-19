resource "aws_ebs_volume" "example-volume" {
  availability_zone = "us-east-1a"
  type              = "gp3"
  size              = 2

  tags = {
    Name = "example-volume"
  }
}

# Snapshot
resource "aws_ebs_snapshot" "example-vol-ss" {
  volume_id   = aws_ebs_volume.k8s_volume.id
  description = "example Snapshot"

  tags = {
    Name = "example-vol-ss"
  }
}
