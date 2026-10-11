resource "aws_sqs_queue" "jobs" {
    name = "${var.name_prefix}-jobs"
    visibility_timeout_seconds = 300
}