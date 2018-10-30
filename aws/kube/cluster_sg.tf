resource "aws_security_group" "kube" {
  name        = "terraform-eks-cluster-${var.app_name}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.kube.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name = "terraform-eks"
  }
}

resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
  cidr_blocks = [
    "38.140.6.10/32",
  ]

  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.kube.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster-ingress-workstation-http" {
  cidr_blocks = [
    "38.140.6.10/32",
  ]

  description       = "Allow workstation to communicate with the cluster on port 8080"
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = "${aws_security_group.kube.id}"
  to_port           = 8080
  type              = "ingress"
}
