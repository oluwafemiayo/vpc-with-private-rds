# Creat user and Groups
module "iam" {
  source  = "terraform-aws-modules/iam/aws"
}

#Create an IAM Group
resource "aws_iam_group" "admin" {
  name = "Admin"
}

resource "aws_iam_group" "dev" {
  name = "Dev"
}

# Create IAM Users
resource "aws_iam_user" "john" {
  name = "John"
}

resource "aws_iam_user" "stuart" {
  name = "Stuart"
}

# Add John to Admin Group
resource "aws_iam_group_membership" "admin_john" {
  name   = "John"
  users  = [aws_iam_user.john.name]
  group  = aws_iam_group.admin.name
}

# Add Stuart to Dev Group
resource "aws_iam_group_membership" "dev_stuart" {
  name   = "Stuart"
  users  = [aws_iam_user.stuart.name]
  group  = aws_iam_group.dev.name
}

# Create IAM Policy
resource "aws_iam_policy" "rds_admin_policy" {
  name        = "rds_admin_policy"
  path        = "/"
  description = "Allow full access to RDS"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "rds:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach IAM Policy to Admin Group
resource "aws_iam_group_policy_attachment" "admin_policy_attachment" {
  group       = aws_iam_group.admin.name
  policy_arn  = aws_iam_policy.rds_admin_policy.arn
}

# # Create an IAM policy to allow view and access to RDS monitoring metrics
 resource "aws_iam_policy" "rds_monitoring_policy" {
   name = "RDSMonitoringPolicy"
   policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Effect = "Allow"
         Action = [
           "cloudwatch:GetMetricData",
           "cloudwatch:GetMetricStatistics",
           "cloudwatch:ListMetrics"
         ]
         Resource = "*"
       }
     ]
   })
 }

# Attach IAM Policy to Dev Group
resource "aws_iam_group_policy_attachment" "rds_monitoring_policy_attachment" {
  group       = aws_iam_group.dev.name
  policy_arn  = aws_iam_policy.rds_monitoring_policy.arn
}