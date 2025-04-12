# Replace with the actual name of your manually created EKS cluster
variable "cluster_name" {
  default = "CustomClusterChemch"
}

variable "region" {
  default = "us-east-1"
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "aws" {
  region = var.region
}