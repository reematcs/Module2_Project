variable "ami_id" {
    default = "ami-00eeedc4036573771" 
}
variable "vpc_id"{
    default="vpc-08f2abf6a26c882f0"
}
variable "aws_terraform_keyname" {
    default = "aws_terraform"
}

# variable "aws_access_key" {
#     default = ""
# }
# variable "aws_secret_key" {
# default = "AORTl908IU2hHrJWYDjGaAicshC01XWqXoHv05z/"
# }
# variable "aws_token" {
#   default = "FwoGZXIvYXdzELf//////////wEaDB7OS8Jo2Pwsg6vEyiK3AQSh3ZRUN2jwVC1bneiy8A/WIv4PYgZJGUHdAvyDQUmwIui7pxQAMysdmR2eqVHDSxM4J3cQqQGsOq7u89Nihd7DcW9/qaNWAMbOScG18NJLg2LzFZM/kIb0PeJhvOTXCBmxyP0uIxt655gOy6GfDzLT7vTy6W2ugZUb7zLkfhiIUty0CditMts904d6pJ6stj2P1bqqicAmuwEB89dQ0vXwe/+z4p9/ZYX6wWvPrKzJTMtCabcmWSjFqe+fBjItZcsC2ZhqzCGUTTaTg1aiZtkxQQK6leA56c5EWIesMPBjuHw926gimogd11B9"
# }
variable "region" {
    default = "us-east-2"
}

variable "bucket_name" {
    default = "project2-reem-ansibledir"
}
variable "acl_value" {
    default = "public-read"
}

variable "ansible_zip" {
  default = "ansible.zip"
}
variable "git_repo" {
    default = "https://github.com/koddas/war-web-project.git"
    #default = "https://github.com/shekhargulati/boot-angular-pagination-example-app"
}
variable "project_dir" {
  default = "sparkjava-hello-world-1.0"
}