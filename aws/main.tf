provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "tf-eks-hero-us-east-1"
    key    = "terraform"
    region = "us-east-1"
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