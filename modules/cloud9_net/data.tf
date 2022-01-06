data "aws_vpc" "vpc-cicd" {
  default = false
  filter {
    name   = "tag:workshop"
    values = ["eks-cicd"]
  }
}

data "aws_vpc" "vpc-default" {
  default = true
}

data "aws_route_table" "cicd-rtb" {
  vpc_id = data.aws_vpc.vpc-cicd.id
  filter {
    name   = "tag:Name"
    values = ["rtb-eks-cicd-priv1"]
  }
}
variable "c9label" {
  description = "Cloud9 IDE Name Label"
  type        = string
  default     = "cloud9-eks-terraform"
}

output c9lab {
  value = "%{ if var.c9label != "" } true %{else} false %{endif}"
}


data "aws_instance" "c9inst" {

  filter {
    name   = "tag:Name"
    values = ["*${var.c9label}*"]
  }
}

data "aws_security_group" "c9sg" {
  name = sort(data.aws_instance.c9inst.security_groups)[0]
}


data "aws_iam_instance_profile" "c9ip" {
  name = data.aws_instance.c9inst.iam_instance_profile
}

output c9role {
  value = data.aws_iam_instance_profile.c9ip.role_arn
}
data "aws_security_group" "cicd-sg" {
  vpc_id = data.aws_vpc.vpc-cicd.id
  filter {
    name   = "tag:workshop"
    values = ["eks-cicd"]
  }
}













