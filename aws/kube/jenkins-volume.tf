resource "aws_ebs_volume" "jenkins" {
  availability_zone = "${var.aws_region_storage}"
  size = 8
  tags {
    Name = "jenkins"
  }
}

output "jenkins-volume" {
  value = "${aws_ebs_volume.jenkins.availability_zone}/${aws_ebs_volume.jenkins.id}"
}

resource "aws_ebs_volume" "jenkins-gradle" {
  availability_zone = "${var.aws_region_storage}"
  size = 8
  tags {
    Name = "jenkins"
  }
}

output "jenkins-gradle-volume" {
  value = "${aws_ebs_volume.jenkins-gradle.availability_zone}/${aws_ebs_volume.jenkins-gradle.id}"
}