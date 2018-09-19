data "aws_ami" "eks-worker" {
  filter {
    name = "name"

    values = [
      "amazon-eks-node-v*",
    ]
  }

  most_recent = true

  owners = [
    "602401143452",
  ]

  # Amazon Account ID
}

data "aws_region" "current" {}

locals {
  node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' '${var.app_name}'
USERDATA
}

resource "aws_launch_configuration" "kube" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks"

  security_groups = [
    "${aws_security_group.node.id}",
  ]

  user_data_base64 = "${base64encode(local.node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "kube" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.kube.id}"
  max_size             = 2
  min_size             = 1
  name                 = "terraform-eks"

  vpc_zone_identifier = [
    "${aws_subnet.kube.*.id}",
  ]

  tag {
    key                 = "Name"
    value               = "terraform-eks"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.app_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.kube.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}
