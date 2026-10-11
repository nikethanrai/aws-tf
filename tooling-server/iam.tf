resource "aws_iam_role" "tooling_host" {
  name = "tooling-host-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tooling"
  }

}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.tooling_host.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "tooling_host" {
  name = "tooling_host_profile"
  role = aws_iam_role.tooling_host.name

}