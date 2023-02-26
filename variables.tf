variable "ami_id" {
    default = "ami-00eeedc4036573771" 
}
variable "vpc_id"{
    default="vpc-0723e281c6bdca95f"
}
variable "aws_terraform_keyname" {
    default = "aws_terraform"
}
variable "aws_access_key" {
    default = "ASIA37M36QKR5U52CFHL"
}
variable "aws_secret_key" {
default = "wMK8a6ej//coPngpCZmGDoi/rl3NNbmkTMG4rhFD"
}
variable "aws_token" {
  default = "FwoGZXIvYXdzEK///////////wEaDLsTF9RK09PyPc1ikiK3AelyRFZ+xQQ/8uKUV+hA04C2UX38RCdrc+vXdaX65iQEoDuyz/XNLF177HACwq7Cxpl/81wU3G9BOsUBedUGztw4p8lb0Y0YgyhZNKBeJeMqdUoj7h4Xn3bxKjGWdCKg/6rrNAnPJfsLvhXB/O5vsFHpFR4DPqOJkZ48jxgl1+mGvPsJdy3B4xNFPhhlI1Uk28UsBFIrAszyYmkSZeaiGYkFF+zOJl4EL7kQ7B5V5An0pe/KUSxVHiivuu2fBjItBQ1be9xS/NJjVXF1dHPN2eHbW2zn/SrFg2z9q/kYO1ciUkwzBfK6uKAUxjda"
}
variable "region" {
    default = "region"
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