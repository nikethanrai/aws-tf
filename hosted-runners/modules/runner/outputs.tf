output "queue_url" {
    value = aws_sqs_queue.jobs.url
}

output "asg_name" {
    value = aws_autoscaling_group.runner.name
  
}