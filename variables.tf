# variable "project_name" {
#   type = string
#   default = "test"
# }
variable "ami_id" {
    default = "ami-0557a15b87f6559cf"
  
}
variable "vpc_id"{
    default="vpc-0614afb1668a1e8dd"
}

variable "bucket_name" {
    default = "projectmodule2-reem-ansibledir"
}

variable "aws_terraform_keyname" {
    default = "aws_terraform"
  
}

variable "acl_value" {

    default = "private"

}

variable "aws_access_key" {

default = "ASIA37M36QKRZRI5F24J"

}

variable "aws_secret_key" {

default = "RVUGwGbOQgkfP70AzkwPjmQFrG+23J2vX92gJFI4"

}

variable "aws_token" {
  default = "FwoGZXIvYXdzEIj//////////wEaDCCfLUIERj8DQw083iK3AW45SjMETaf4l2tdyitq3k93g/NSHJAtdfn7g6li5BK5CxVSr9Iw4nHdtthTbN14F5O3mIgP6kWShgWkD/gVR7YFjsZVhzRSZKl1Hx/Uoa0uE7sFWJdh5entV0YjHYQuXVQ98AWBeRO4QA19IzUfqTc5h2ml/63PTuTvBfVykwnxfkBTc7Jga4wqA+sFiKCvIs72oRTZNSFT547F3+dWS1OYsjtMA3/Py0xynwo2515Pu24Lh/CAlyjV7eSfBjIt0Xld7CIyCFcZbW7j6DKexrHpV8D6ak07oF97iKPcKVRGMcd+EzQkAjaZb510"
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