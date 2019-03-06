resource "aws_iam_instance_profile" "aws-lambda-role" {
	name = "aws-lambda-role"
	role = "${aws_iam_role.lambda-role.name}"
}

resource "aws_iam_role" "lambda-role" {
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

resource "aws_iam_role_policy_attachment" "CloudWatchActionsEC2Access" {
    role       = "${aws_iam_role.lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchActionsEC2Access"
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
    role       = "${aws_iam_role.lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = "${aws_iam_role.lambda-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

