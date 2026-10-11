data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default"{
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]
    }
}

data "aws_ami" "amazon_linux"{
    most_recent = true
    owners = ["amazon"]
    filter {
      name ="name"
      values = ["al2023-ami-*-x86_64"]
    }
}

resource "aws_instance" "tooling_host" {

 ami = data.aws_ami.amazon_linux.id
 instance_type = "t3.micro"
 subnet_id = data.aws_subnets.default.ids[0]
 iam_instance_profile = aws_iam_instance_profile.tooling_host.name
 vpc_security_group_ids = [aws_security_group.instance_connect.id]

 tags = {
   Name = "tooling-host"
 }
  
}


