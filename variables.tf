variable "ami_id" {
    default = "ami-00eeedc4036573771" 
}
variable "vpc_id"{
    default="vpc-056d622c7a32e4729"
}
variable "aws_terraform_keyname" {
    default = "aws_terraform"
}
variable "aws_access_key" {
    default = "ASIA37M36QKR5ICDTSWB"
}
variable "aws_secret_key" {
default = "hyoxDGRT68Ng77YKiRi6EHvAOLp9ur/PFGE30his"
}
variable "aws_token" {
  default = "FwoGZXIvYXdzEJ3//////////wEaDMciMATn78cZG/fgYyK3AbIjLOvhIQj8sQPfqUAjDY8dkVVAaWjvKQwsUfnh+bGUbuwOsotCoTug7vmYOklSU1vhQJs/b5n2AxrOPXbU+sSLJroDRgfVA76VpxUWrGLr93pW9I7QVen4NHKLirddwVw++5p8U5nuKM0EQQv/sgS122dHxuUOYCc0PhNLJjTNbiJAXfJWdNVLn8YOYfyb7VY4Df+icz6rrlGCau3dlOXL/jljbYW6rOaH6Di9Ms1D4+M+6aS0byiyvOmfBjItK8z3LX1EDH9S3F0M3sb1p/PAsXtOy+90Jpsc/jX3XW4S8uqDtPth/5BG5wf+"
}
variable "region" {
    default = "region"
}

variable "bucket_name" {
    default = "project2-reem-ansibledir"
}
variable "acl_value" {
    default = "public"
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