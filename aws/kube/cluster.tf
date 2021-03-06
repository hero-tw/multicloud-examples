resource "aws_eks_cluster" "cluster" {
  name     = "${var.env_name}"
  role_arn = "${aws_iam_role.kube-role.arn}"

  vpc_config {
    security_group_ids = [
      "${aws_security_group.kube.id}",
    ]

    subnet_ids = [
      "${aws_default_subnet.kube.*.id}",
      "${aws_default_subnet.kube2.*.id}",
    ]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy",
  ]
}

locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.env_name}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
