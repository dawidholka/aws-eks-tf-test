module "network" {
  source = "./modules/network"

  cluster-name = var.cluster-name
}

module "iam" {
  source = "./modules/iam"

  depends_on = [module.network]
}

module "cloud9_network_link" {
  source = "./modules/cloud9_net"

  allnodes-sg = module.network.allnodes-sg
  cluster-sg  = module.network.cluster-sg
  eks-cidr    = module.network.eks-cidr
  eks-vpc     = module.network.eks-vpc
  rtb-priv1   = module.network.rtb-priv1
  rtb-priv2   = module.network.rtb-priv2
  rtb-priv3   = module.network.rtb-priv3

  depends_on = [module.iam]
}

module "eks_cluster" {
  source = "./modules/cluster"

  cluster-name             = var.cluster-name
  cluster-sg               = module.network.cluster-sg
  cluster_service_role_arn = module.iam.cluster_service_role_arn
  sub-priv1                = module.network.sub-priv1
  sub-priv2                = module.network.sub-priv2
  sub-priv3                = module.network.sub-priv3

  depends_on = [module.cloud9_network_link]
}

module "node_group" {
  source = "./modules/node_group"

  allnodes-sg        = module.network.allnodes-sg
  cluster-name       = var.cluster-name
  key_name           = module.iam.key_name
  nodegroup_role_arn = module.iam.nodegroup_role_arn
  sub-priv1          = module.network.sub-priv1
  sub-priv2          = module.network.sub-priv2
  sub-priv3          = module.network.sub-priv3

  depends_on = [module.eks_cluster]
}

module "cicd" {
  source = "./modules/cicd"

  depends_on = [module.node_group]
}

module "eks_cidr" {
  source = "./modules/eks_cidr"

  cluster-name = var.cluster-name
  eks-vpc      = module.network.eks-vpc

  depends_on = [module.cicd]
}

module "load_balancer" {
  source = "./modules/load_balancer"

  cluster-name = var.cluster-name
  region       = var.region

  depends_on = [module.eks_cidr]
}

module "app" {
  source = "./modules/app"

  depends_on = [module.load_balancer]
}
