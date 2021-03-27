# group definition
resource "aws_iam_group" "administrators" {
  name = var.group_name
}

# attach policy to group
resource "aws_iam_policy_attachment" "administrators-attach" {
  name       = var.policy_name
  groups     = [aws_iam_group.administrators.name]
  policy_arn = var.policy_arn
}

# user
resource "aws_iam_user" "admin1" {

  count = length(var.user_names) 
  name = var.user_names[count.index]
}

# adding users to group
resource "aws_iam_group_membership" "administrators-users" {
  name = var.membership_name
  
  # for_each = toset([for user in var.user_names : tostring(user)])
  # for_each = var.user_names2
  # for_each = { for index, user in var.user_names: index => user }
  count = length(var.user_names)

  users = [
    aws_iam_user.admin1[count.index].name

  ]
  group = aws_iam_group.administrators.name
}

output "warning" {
  value = "WARNING: make sure you're not using the AdministratorAccess policy for other users/groups/roles. If this is the case, don't run terraform destroy, but manually unlink the created resources"
}