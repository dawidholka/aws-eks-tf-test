resource "aws_iam_role" "eks-cluster-ServiceRole-HUIGIC7K7HNJ" {
  assume_role_policy    = jsonencode(
  {
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = [
            "eks-fargate-pods.amazonaws.com",
            "eks.amazonaws.com",
          ]
        }
      },
    ]
    Version   = "2012-10-17"
  }
  )
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "eks-cluster-ServiceRole-HUIGIC7K7HNJ"
  path                  = "/"
  tags                  = {
    "Name" = "eks-cluster/ServiceRole"

  }
}

output "cluster_service_role_arn" {
  value = aws_iam_role.eks-cluster-ServiceRole-HUIGIC7K7HNJ.arn
}

resource "aws_iam_role" "eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO" {
  assume_role_policy    = jsonencode(
  {
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
    Version   = "2012-10-17"
  }
  )
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO"
  path                  = "/"
  tags                  = {
    "Name" = "eks-nodegroup-ng-maneksami2/NodeInstanceRole"
  }
}

output "nodegroup_role_arn" {
  value = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO.arn
}
