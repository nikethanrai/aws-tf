data "aws_ip_ranges" "ec2_instance_connect"{
    services = ["ec2_instance_connect"]
    regions = ["ap-southeast-2"]
}

resource "aws_security_group" "instance_connect" {
    name = "tooling-host-instance-connect"
    description = "ssh access to ec2 instance connect"
    vpc_id = data.aws_vpc.default.id

    ingress {
        description = "SSH from ec2 instance ocnnect"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = data.aws_ip_ranges.ec2_instance_connect.cidr_blocks
    }

    egress {
        from_port =0
        to_port =0
        protocol ="-1"
        cidr_blocks =["0.0.0.0/0"]
    }
  
}