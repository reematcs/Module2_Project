resource "aws_s3_bucket" "b1" {
  bucket = "${var.bucket_name}" 
  force_destroy=true
  tags = {
    Name        = "projectmodule2-reem-ansibledir"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "ansible_provision" {
  bucket = aws_s3_bucket.b1.id
  acl    = "public"
}