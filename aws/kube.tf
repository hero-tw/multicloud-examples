#
provider "aws" {
  region = "${var.eks-region}"
}

#
module "eks-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = "${var.eks-azs}"
  private_subnets = "${var.eks-private-cidrs}"
  public_subnets  = "${var.eks-public-cidrs}"

  enable_nat_gateway = false
  single_nat_gateway = true

  #  reuse_nat_ips        = "${var.eks-reuse-eip}"
  enable_vpn_gateway = false

  #  external_nat_ip_ids  = ["${var.eks-nat-fixed-eip}"]
  enable_dns_hostnames = true

  tags = {
    Terraform                                   = "true"
    Environment                                 = "${var.environment_name}"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = "${module.eks-vpc.default_security_group_id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_guestbook" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "TCP"
  security_group_id = "${module.eks-vpc.default_security_group_id}"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_eks_cluster" "eks-cluster" {
  name = "${var.cluster-name}"

  role_arn = "${aws_iam_role.demo-cluster.arn}"

  vpc_config {
    subnet_ids = ["${module.eks-vpc.public_subnets}"]
  }
}

output "endpoint" {
  value = "${aws_eks_cluster.eks-cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}"
}