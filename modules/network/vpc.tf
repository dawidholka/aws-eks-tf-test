resource "aws_vpc" "cluster" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "10.0.0.0/22"
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags                             = {
    "Name" = format("eks-%s-cluster", var.cluster-name)
  }
}

resource "aws_vpc" "vpc-cicd" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "172.30.0.0/24"
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = false
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Name"     = "eks-cicd"
    "workshop" = "eks-cicd"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "vpc-cidr-assoc" {
  cidr_block = "100.64.0.0/16"
  vpc_id     = aws_vpc.cluster.id

  timeouts {}
}
