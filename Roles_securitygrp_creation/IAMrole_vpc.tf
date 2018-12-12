resource "aws_iam_instance_profile" "aws-lambda-role" {
	name = "aws-lambda-role"
	role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "aws-lambda-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_security_group" "lambda-redis" {
	name = "lambda-redis-sg"
	description = "Lambda Redis Security Group"
	vpc_id = "${var.vpc-id}"

	ingress {
		from_port = 6379
		to_port   = 6379
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
		test = "${var.tag}"
	  }
}

