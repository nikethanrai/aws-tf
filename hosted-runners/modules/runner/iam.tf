resource "aws_iam_role" "runner" {
    name = "${var.name_prefix}-runner-role"
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
}

resource "aws_iam_role_policy" "runner-sqs" {
    name = "${var.name_prefix}-runnner_sqs"
    role = aws_iam_role.runner.id

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Action = [
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = aws_sqs_queue.jobs.arn
      }]
    })


  
}

resource "aws_iam_role_policy_attachment" "runner_ssm" {
    role = aws_iam_role.runner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  
}


resource "aws_iam_instance_profile" "runner" {
  name = "${var.name_prefix}-runner-profile"
  role = aws_iam_role.runner.name

}
