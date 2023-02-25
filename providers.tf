provider "aws" {
	region     = "us-east-2"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}" # TODO: REplace with file
	token = "${var.aws_token}"
}