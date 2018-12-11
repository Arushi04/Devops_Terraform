# AWS Config

variable "aws_access_key" {
	default = "<access key>"
}

variable "aws_secret_key" {
	default = "<aws secret access key>"
}

variable "aws_region" {
	default = "ap-south-1"
}

variable "tag" {
	default     = "test"
}

variable "keypair" {
	default     = "testkeypair_mumbai"
}
