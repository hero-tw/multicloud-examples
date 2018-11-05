resource "aws_ebs_volume" "jenkins" {
  availability_zone = "${var.aws_region_storage}"
  size = 8
  tags {
    Name = "jenkins-${var.app_name}"
  }
}


resource "aws_ebs_volume" "jenkins-gradle" {
  availability_zone = "${var.aws_region_storage}"
  size = 8
  tags {
    Name = "jenkins-gradle-${var.app_name}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.app_name}"
  subnet_ids = ["${aws_subnet.kube.*.id}"]

  tags {
    Name = "${var.app_name} subnet group"
  }
}

resource "random_string" "password" {
  length = 16
  special = false
}


resource "aws_db_instance" "db" {
  identifier             = "${var.app_name}-sonar"
  allocated_storage      = "10"
  engine                 = "postgres"
  engine_version         = "9.6.8"
  instance_class         = "db.t2.micro"
  name                   = "sonar"
  username               = "sonar"
  port                   = "5432"
  skip_final_snapshot    = true
  final_snapshot_identifier = "${var.app_name}-sonar-final-snapshot"
  password               = "${random_string.password.result}"
  vpc_security_group_ids = ["${aws_vpc.kube.default_security_group_id}", "${aws_security_group.node.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.name}"
}


output "jenkins-volume" {
  value = "${aws_ebs_volume.jenkins.availability_zone}/${aws_ebs_volume.jenkins.id}"
}

output "jenkins-gradle-volume" {
  value = "${aws_ebs_volume.jenkins-gradle.availability_zone}/${aws_ebs_volume.jenkins-gradle.id}"
}


output "sonar-postgres-address" {
  value = "${aws_db_instance.db.address}:${aws_db_instance.db.port}/${aws_db_instance.db.name}"
}

output "sonar-postgres-password" {
  value = "${aws_db_instance.db.password}"
}


