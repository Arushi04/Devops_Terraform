resource "aws_instance" "ec2Demo" {
	ami             = "${data.aws_ami.amazon-linux.id}"
	instance_type   = "t2.micro"
	key_name        = "${var.keypair}"
	vpc_security_group_ids   = ["${aws_security_group.ec2-talend.id}"]
	tags {
		Name   = "demo"
		funnel = "${var.tag}"
	}
}

data "aws_ami" "amazon-linux" {
	most_recent = true

	filter {
		name   = "owner-alias"
		values = ["amazon"]
	}

	filter {
	name   = "name"
	values = ["amzn-ami-hvm*"]
	}
}

data "aws_vpc" "default" {
	default = true
}


data "aws_subnet_ids" "all" {
	vpc_id = "${data.aws_vpc.default.id}"
}


resource "aws_security_group" "ec2-talend" {
	name = "ec2-talend"
	description = "EC2 Talend Security Group"
	vpc_id = "${data.aws_vpc.default.id}"

	ingress {
		from_port = 22
		to_port   = 22
		protocol  = "tcp"
		cidr_blocks = ["0.0.0.0/0"] #using the cidr block for default VPC
	  }

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags {
		funnel = "${var.tag}"
		Name = "EC2 Talend sg"
    	}

}



