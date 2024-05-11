# resource "aws_eks_cluster" "xcoin-cluster" {
#   #source  = "terraform-aws-modules/eks/aws"
#   version  = "~> 20.0"
#   role_arn = "arn:aws:iam::452817723078:role/LabRole"
#   name     = "xcoin-cluster-eks"
#   #  cluster_name    = "xcoin-cluster-eks"
#   #  cluster_version = "1.29"

#   vpc_config {
#     subnet_ids = ["subnet-026aa9fc097e1f1f8", "subnet-0bc68bccc25aa8a3f", "subnet-007082c15ee131651"]
#   }
#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#   ]
#   #  vpc_id                          = "vpc-0247adcba0e5e1e0c"
#   #   cluster_endpoint_public_access  = true
#   #   cluster_endpoint_private_access = true

#   #   cluster_addons = {
#   #     coredns = {
#   #       most_recent = true
#   #     }
#   #     kube-proxy = {
#   #       most_recent = true
#   #     }
#   #     vpc-cni = {
#   #       most_recent = true
#   #     }
#   #     csi = {
#   #       most_recent = true
#   #     }
#   #   }

#   #   eks_managed_node_groups = {
#   #     node-group = {
#   #         iam_role_arn = "arn:aws:iam::452817723078:role/LabRole"
#   #       min_size     = 1
#   #       max_size     = 3
#   #       desired_size = 1

#   #       instance_types = ["t3.medium"]
#   #     }
#   #   }

#   #   tags = {
#   #     Environment = "Prod"
#   #     Terraform   = "true"
#   #   }
# }

# output "endpoint" {
#   value = aws_eks_cluster.xcoin-cluster
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.xcoin-cluster.certificate_authority[0].data
# }
