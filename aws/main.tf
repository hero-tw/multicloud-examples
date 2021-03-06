provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    key    = "terraform"
  }
}

module "kube" {
  source = "./kube"

  env_name = "${var.env_name}"
  aws_region_storage = "${var.aws_region_storage}"
}

output "env_name" {
  value = "${var.env_name}"
}

output "aws-region" {
  value = "${var.aws_region}"
}

output "aws-region_storage" {
  value = "${var.aws_region_storage}"
}

output "kubeconfig" {
  value = "${module.kube.kubeconfig}"
}


output "config-map" {
  value = "${module.kube.config-map-aws-auth}"
}

output "jenkins-volume" {
  value = "${module.kube.jenkins-volume}"
}
output "jenkins-gradle-volume" {
  value = "${module.kube.jenkins-gradle-volume}"
}

output "sonar-postgres-address" {
  value = "${module.kube.sonar-postgres-address}"
}

output "sonar-postgres-password" {
  value = "${module.kube.sonar-postgres-password}"
}


