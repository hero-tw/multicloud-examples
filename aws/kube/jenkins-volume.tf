resource "aws_ebs_volume" "jenkins" {
  availability_zone = "us-west-2a"
  size = 8
  tags {
    Name = "jenkins"
  }
}

output "jenkins-volume" {
  value = "${aws_ebs_volume.jenkins.id}"
}