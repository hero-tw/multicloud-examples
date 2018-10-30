resource "aws_ebs_volume" "jenkins" {
  availability_zone = "us-west-2a"
  size = 8
  tags {
    Name = "jenkins"
  }
}