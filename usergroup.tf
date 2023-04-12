# # Create the Admin group
# resource "aws_iam_group" "admin_group" {
#   name = "Admin"
# }

# # Create the Dev group
# resource "aws_iam_group" "dev_group" {
#   name = "Dev"
# }

# # Create John user and add to Admin group
# resource "aws_iam_user" "john_user" {
#   name = "John"
# }

# resource "aws_iam_group_membership" "john_group_membership" {
#   group = aws_iam_group.admin_group.name
#   users = [aws_iam_user.john_user.name]
# }

# # Create Stuart user and add to Dev group
# resource "aws_iam_user" "stuart_user" {
#   name = "Stuart"
# }

# resource "aws_iam_group_membership" "stuart_group_membership" {
#   group = aws_iam_group.dev_group.name
#   users = [aws_iam_user.stuart_user.name]
# }

# # Create an IAM policy to allow full access to RDS instance
# resource "aws_iam_policy" "rds_full_access_policy" {
#   name = "RDSFullAccessPolicy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "rds:*"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# # Create an IAM policy to allow view and access to RDS monitoring metrics
# resource "aws_iam_policy" "rds_monitoring_policy" {
#   name = "RDSMonitoringPolicy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "cloudwatch:GetMetricData",
#           "cloudwatch:GetMetricStatistics",
#           "cloudwatch:ListMetrics"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# # Attach policies to groups
# resource "aws_iam_policy_attachment" "admin_policy_attachment" {
#   name = "AdminPolicyAttachment"
#   policy_arn = aws_iam_policy.rds_full_access_policy.arn
#   groups = [aws_iam_group.admin_group.name]
# }

# resource "aws_iam_policy_attachment" "dev_policy_attachment" {
#   name = "DevPolicyAttachment"
#   policy_arn = aws_iam_policy.rds_monitoring_policy.arn
#   groups = [aws_iam_group.dev_group.name]
# }
