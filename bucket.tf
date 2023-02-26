resource "aws_s3_bucket" "b1" {
  bucket = "${var.bucket_name}" 
  force_destroy=true
  tags = {
    Name        = "${var.bucket_name}"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "ansible_provision" {
  bucket = aws_s3_bucket.b1.id
  acl    = "${var.acl_value}"
}


# resource "aws_s3_bucket_policy" "public_read_access" {
#   bucket = aws_s3_bucket.b1.id
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
# 	  "Principal": "*",
#       "Action": [ "s3:*" ],
#       "Resource": [
#         "${aws_s3_bucket.b1.arn}",
#         "${aws_s3_bucket.b1.arn}/*"
#       ]
#     }
#   ]
# }
# EOF
# }