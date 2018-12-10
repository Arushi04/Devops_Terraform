resource "aws_db_instance" "testdb" {
	identifier 	       = "testdb"  //specifies the name through which RDS instance is created
	allocated_storage      = "${var.storage}"
	engine                 = "postgres"
	engine_version         = "9.6.6"
	instance_class         = "db.t2.medium"
	name                   = "testdb"
	username               = "${var.username}"
	password               = "${var.password}"
	vpc_security_group_ids = ["${aws_security_group.rds.id}"]
	parameter_group_name   = "default.postgres9.6"
	backup_retention_period= "20"
	backup_window	       = "19:32-20:02"
	storage_type 	       = "gp2"
	publicly_accessible    = "true"
	tags {
		testing = "${var.tag}"
	}
}

resource "aws_security_group" "rds" {
	name = "rds-sg"
	description = "RDS Security Group"
	vpc_id = "${var.vpc-id}"

	ingress {
		from_port = 5432
		to_port   = 5432
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
		testing = "${var.tag}"
	  }
}










