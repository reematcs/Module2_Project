# variable "project_name" {
#   type = string
#   default = "test"
# }

variable "git_repo" {
    default = "https://github.com/koddas/war-web-project.git"
    #default = "https://github.com/shekhargulati/boot-angular-pagination-example-app"
}

variable "project_dir" {
  default = "sparkjava-hello-world-1.0"
}

variable "ami_id" {
    default = "ami-00eeedc4036573771"
  
}
variable "vpc_id"{
    default="vpc-056d622c7a32e4729"
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

default = "ASIA37M36QKRRW6KKCMU"

}

variable "aws_secret_key" {

default = "UMfL7rnqB2UEJYD7TdKh602nrFtWU3P4/5WWJmFW"

}

variable "aws_token" {
  default = "FwoGZXIvYXdzEJX//////////wEaDI6ANg0tI9z8nuyOdCK3ASfYFf4Vr70PT6/tFORu1IR3E0f6R08Uut5kQ2j8Nkji2SX/1nQ8i4Fa0TNM6F94W8n8LOc893l/Vc3gxdVmU4Z7DfyiLpa7k96RUcsOsJnZFL4xlkxHF+5X2XKJlfnAbXZBe+VWSu8mIeGGQfUE4RRIgxnChMtEvMcQr3Z6AdiT4T5eqgyR8l/KN3/dVX0XypvRJ2+z21T81EjId8a8ipjGT/81DZguruu+AX2jRrK2AMr41fIt/Cj12eefBjItRwWsnqir4AbSluyStN0yQi28dsQXl08lRx857yy8SoxX9l5kU790ag9fRryk"
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