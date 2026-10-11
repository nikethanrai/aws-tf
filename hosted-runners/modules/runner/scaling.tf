resource "aws_autoscaling_policy" "backlog_per_instance" {
    name = "${var.name_prefix}-backlog-per-instance"
    autoscaling_group_name = aws_autoscaling_group.runner.name
    policy_type = "TargetTrackingScaling"

    target_tracking_configuration {
    target_value = 1
    customized_metric_specification {
      metrics {
        return_data = false
        id    = "m1"
        metric_stat {
            stat   = "Average"
          metric {
            namespace   = "AWS/SQS"
            metric_name = "ApproximateNumberOfMessagesVisible"
            dimensions {
              name  = "QueueName"
              value = aws_sqs_queue.jobs.name
            }
          }
         
        }
      }
        metrics {
        id    = "m2"
        return_data = false

        metric_stat {
            stat   = "Average"
          metric {
            namespace   = "AWS/AutoScaling"
            metric_name = "GroupInServiceInstances"
            dimensions {
              name  = "AutoScalingGroupName"
              value = aws_autoscaling_group.runner.name
            }
          }

        }
      }
      metrics {
        label       = "Calculate the backlog per instance"
        id          = "backlog_per_instance"
        expression  = "IF(m2 > 0, m1 /m2, m1)"
        return_data = true
      }
    }
  }
}
