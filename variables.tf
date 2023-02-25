# variable "project_name" {
#   type = string
#   default = "test"
# }
variable "ami_id" {
    default = "ami-00eeedc4036573771"
  
}
variable "vpc_id"{
    default="vpc-04fcb550eef68165c"
}

variable "bucket_name" {
    default = "project2-reem-ansibledir"
}

variable "aws_terraform_keyname" {
    default = "aws_terraform"
  
}

variable "acl_value" {

    default = "private"

}

variable "aws_access_key" {

default = "ASIA37M36QKRUHVFPJDD"

}

variable "aws_secret_key" {

default = "gdQIS7NV5vxAvE5oKp8E32j8KgddZvlGZYI/rgJO"

}

variable "aws_token" {
  default = "FwoGZXIvYXdzEIr//////////wEaDG172RFhQDI17u+ffSK3AWkdRajWIaPef0ZpTkcy/UvpyVbocULuKcxlVO3GkFGYDDx+7wB01jhOqsLzkynhd/xD47XQpIIEOQETKLn/+K5nK7Yit08IeTJ2KF3UjPFfhyEN0IXfI0mMdvJ8Yemf2k5j2GF5ibn/MVcoY1g4hiwkj/StuTDCTRcLTswA6Nn3ayeYXQNvDtfWGJ3glWkJb5PNaVnJjlE9gL8ZhGp84uEWO7cz3+bHVSTHBzvTMB/W3LaSW94ziijBp+WfBjItjBWeWw71r8Y+rCiRO2yzLzJq91Z0V+krO6W/HNEA4Th9Hc1jkMi+h+r8rsgU"
}
variable "region" {

    default = "region"

}

# variable create_bucket {
#     type = bool

# }

variable "ansible_zip" {
  default = "ansible.zip"
}