resource "aws_elastic_beanstalk_application" "test_app" {
	name        = "test"
	description = "testapp-envt"
	
}

resource "aws_elastic_beanstalk_environment" "test-envt" {
	name                = "test-envt"
	application         = "${aws_elastic_beanstalk_application.test_app.name}"
	solution_stack_name = "${var.stackname}"
	setting {
		namespace = "aws:autoscaling:launchconfiguration"
		name = "IamInstanceProfile"
		value = "${aws_iam_instance_profile.aws-elasticbeanstalk-ec2-role.name}"
	}

	 setting {
		namespace = "aws:autoscaling:launchconfiguration"
		name = "InstanceType"
		value = "${var.instancetype}"
	}

	setting {
		namespace = "aws:autoscaling:launchconfiguration"
		name = "EC2KeyName"
		value = "${var.keypair}"
	}

	 setting {
		namespace = "aws:elasticbeanstalk:healthreporting:system"
		name = "SystemType"
		value = "enhanced"
	}

	setting {
		namespace = "aws:ec2:vpc"
		name = "Subnets"
		value = "${var.subnets}"
	}

	tags {
		funnel = "${var.tag}"
	}
}

resource "aws_iam_instance_profile" "aws-elasticbeanstalk-ec2-role" {
	name = "aws-elasticbeanstalk-ec2-role"
	role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "aws-elasticbeanstalk-ec2-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


