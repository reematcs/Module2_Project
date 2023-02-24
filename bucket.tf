# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "my-s3-bucket"
#   acl    = "private"

#   versioning = {
#     enabled = true
#   }

# }

# data "aws_s3_bucket" "b1" {
#   bucket = "projectmodule2-reem-ansibledir"
# }

# data "aws_s3_bucket" "b2" {
#   bucket = "projectmodule2-reem-ansibledir-2"
# }

resource "aws_s3_bucket" "b1" {
  bucket = "${var.bucket_name}" 

  tags = {
    Name        = "projectmodule2-reem-ansibledir"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "ansible_provision" {
  bucket = aws_s3_bucket.b1.id
  acl    = "private"
}

# resource "aws_s3_object" "b1" {

#     bucket = "${var.bucket_name}" 
#     key = "new_object_key"
#     acl = "${var.acl_value}"  

#   tags = {

#     Name        = "projectmodule2-reem-ansibledir"
#     Environment = "Dev"

#   }
