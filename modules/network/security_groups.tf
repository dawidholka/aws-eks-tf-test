resource "aws_security_group" "eks-cicd-sg" {
  description = "eks-cicd all"
  vpc_id      = aws_vpc.vpc-cicd.id
  tags = {
    "Name"     = "eks-cicd-all"
    "workshop" = "eks-cicd"
  }
}

resource "aws_security_group" "cluster-sg" {
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = aws_vpc.cluster.id
  tags = {
    "Name" = format("eks-%s-cluster/ControlPlaneSecurityGroup",var.cluster-name)
    "Label" = "TF-EKS Control Plane & all worker nodes comms"
  }
}

resource "aws_security_group" "allnodes-sg" {
  description = "Communication between all nodes in the cluster"
  vpc_id      = aws_vpc.cluster.id
  tags = {
    "Name"   = format("eks-%s-cluster/ClusterSharedNodeSecurityGroup",var.cluster-name)
    "Label"  = "TF-EKS All Nodes Comms"
  }
}

