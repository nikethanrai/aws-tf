data "aws_region" "current"{

}

data "aws_ami" "amazon_linux"{
    most_recent = true
    owners =["amazon"]
    filter {
      name ="name"
      values = ["al2023-ami-*-x86_64"]
    }
}

resource "aws_launch_template" "runner" {
    name_prefix = "${var.name_prefix}-runner-"
    image_id = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type

    iam_instance_profile {
      name = aws_iam_instance_profile.runner.name
    }
    user_data = base64encode(templatefile("${path.module}/templates/boot.sh.tpl", {
        queue_url = aws_sqs_queue.jobs.queue_url
        region = data.aws_region.current.name
    }))
  
}

resource "aws_autoscaling_group" "runner" {
    name_prefix = "${var.name_prefix}-runner-"
    vpc_zone_identifier = [var.private_subnet_id]
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    health_check_type = "EC2"

    launch_template {
      id = aws_launch_template.runner.id
      version = "$Latest"
    }
    tag {
      key = "Name"
      value = "${var.name_prefix}-runner"
      propagate_at_launch = true
    }
  
}