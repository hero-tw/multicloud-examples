provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "tf-eks-hero-us-west-1"
    key    = "terraform"
    region = "us-west-1"
  }
}

module "kube" {
  source = "./kube"

  app_name = "${var.app_name}"
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