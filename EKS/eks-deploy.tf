data "aws_vpc" "exiting-main-vpc" {
    tags      = {
    Name      = var.exisitng-vpc-name
  }
}

data "aws_subnets" "public_subnets_ids" {
 
 filter {
    name   = "vpc-id"
    values = [aws_vpc.exiting-main-vpc.id]
     }
  
   tags = {
    Tier = "Public"
  }
}
data "aws_subnets" "private_subnet_ids" {

   filter {
    name   = "vpc-id"
    values = [data.aws_vpc.exiting-main-vpc.id]
  }
  
   tags = {
    Tier = "Private"
  }
}

locals {
private_subnets_ids = toset(data.aws_subnets.private_subnet_ids)
public_subnets_ids  = toset(data.aws_subnets.public_subnets_ids")

}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "pipeline-eks-cluster"
  cluster_version = "1.28"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = private_subnets_ids

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_type = ["t2.small"]
    }
  }

  tags = {
    Name        = "pipeline-eks-cluster"
	Environment = "test"
    Project   = "DOJO-assignment"
  }
}