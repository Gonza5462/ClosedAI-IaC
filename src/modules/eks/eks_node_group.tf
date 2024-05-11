# resource "aws_instance" "kubectl-server" {
#   ami                         = "ami-07caf09b362be10b8"
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   subnet_id                   = "subnet-026aa9fc097e1f1f8"
#   tags = {
#     Name = "master_node"
#   }
# }


# resource "aws_eks_node_group" "node-grp" {
#   cluster_name    = aws_eks_cluster.xcoin-cluster.name
#   node_group_name = "node-group-xcoin"
#   node_role_arn   = aws_iam_role.worker.arn
#   subnet_ids      = ["subnet-026aa9fc097e1f1f8", "subnet-0bc68bccc25aa8a3f", "subnet-007082c15ee131651"]
#   capacity_type   = "ON_DEMAND"
#   disk_size       = "20"
#   instance_types  = ["t2.medium"]


#   scaling_config {
#     desired_size = 1
#     max_size     = 3
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }
