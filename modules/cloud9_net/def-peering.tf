resource "aws_vpc_peering_connection" "def-peer" {
  peer_vpc_id = var.eks-vpc
  vpc_id      = data.aws_vpc.vpc-default.id
  auto_accept = true
}

