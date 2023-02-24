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
    default = "projectmodule2-reem-ansibledir-2"
}

variable "acl_value" {

    default = "private"

}

variable "aws_access_key" {

default = "ASIA37M36QKRQWJB5CQJ"

}

variable "aws_secret_key" {

default = "ZUliyVNJrqfHrEUf1O8vX7/Tt01wAmTi5J34KyQn"

}

variable "aws_token" {
  default = "FwoGZXIvYXdzEID//////////wEaDDhTKnLiAmPE25VCJCK3AfEzbk68/n7FaZohXka+TzaJJ9ua59bATS4p6gTK/a4fNpC63FfIonfo3H5Iq6lYFGhOyWS9fJHFzCQLFQusZcN9il/ry3qc0jwG//oPB0uszTPX+0SI2zT6UMSMVfqDt5PSP1fihdzRJmsF1mPn3Wat+19v7fvWk1kWz51iBM8+/sWrEPmLGf+KzKQ3yITrrJoa4VhaDqqLFaVn3wTZYO9SEjRI0qy8juTtVrKd5tAd2ir4Q/BZ8iiZnuOfBjItAljhk6lsprNk6dJuZy6lTvUr+/YYjfNV1bFNwuDmpHKFpsIfxOZDnerHW6Cc"
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