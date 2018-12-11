resource "aws_instance" "ec2-tf" {
	ami             = "${data.aws_ami.ubuntu.id}"
	instance_type   = "t2.micro"
	key_name        = "${var.keypair}"
	tags {
		Name = "test-ec2"
		funnel = "${var.tag}"
	}
}

data "aws_ami" "ubuntu" {
	most_recent = true

	filter {
		name   = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
	}

	filter {
	name   = "virtualization-type"
	values = ["hvm"]
	}

	owners = ["099720109477"] # Canonical
}



