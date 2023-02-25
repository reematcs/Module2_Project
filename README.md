# Name

Using Terraform and Ansible to provision, Jenkins to Automate Maven packing of WAR file and deployment to Tomcat 9

# Description

## Overview

Terraform, an open-source IaC is used to spin up a EC2 server instance, a deployment instance and S3 bucket to upload ansible provisioning playbooks. 
## Directory Structure
```
Module2_Project
├── README.md
├── ansible_provisioning
│   ├── deploy_war.yml
│   ├── deploy_war_role
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── tests
│   │       ├── inventory
│   │       └── test.yml
│   ├── localhost
│   │   ├── host-manager.xml
│   │   └── manager.xml
│   ├── maven_build_role
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── tests
│   │       ├── inventory
│   │       └── test.yml
│   ├── tomcat-users.xml
│   └── tomcat_playbook.yml
├── aws_terraform.pem
├── bucket.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf

9 directories, 22 files
```

## Summary of Steps Performed:

1. [Terraform:](#terraform)
    1. Spun up S3 bucket
    2. Spun up 2 EC2 instances, provisioning server and deployment, and generated their public and private ips. Attached necessary IAM role to EC2 instances to access S3 bucket.
    3. Placed Ansible provisioning playbooks and roles, with inventory file for deployment ip address. Zipped using Terraform and uploaded to S3 bucket.
    4. Downloaded ansible playbook using awscli commands to EC2 provisioning server. Unzipped. Generated ssh keys to connect with deployment server and uploaded to S3 bucket.
    5. Downloaded and appended ssh public key using awscli commands to deployment instance in authorized_keys.
    6. Used Terraform to run ansible playbooks.
2. [Ansible:](#ansible)
    1. Tomcat setup on deployment server.
    2. Clone and build Hello World WAR file using maven on provisioning server.
    3. Deploy WAR file and restart Tomcat on deployment server.
3. [Jenkins:](#jenkins)
    1. Manual setup of pipeline in [previous step](#ansible)
    2. Testing and validating pipeline.


# Terraform:
## 1. Setup
### 1. Basic Setup
Inside `main.tf`, we ensure that Terraform uses a specific version for Terraform and our required providers (aws).

```HCL
terraform{
required_version = ">= 1.0" # semver 
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "4.55.0"
        }
      }
}
```
Inside `variables.tf`, we setup the requirements for our Virtual Private Cloud and instance settings, as well as the AWS key `aws_terraform_keyname` for creating, managing and accessing our resources.

```HCL
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
    default = "..."
}
variable "aws_secret_key" {
default = "..."
}
variable "aws_token" {
  default = "..."
}
variable "region" {
    default = "region"
}
```
Inside `main.tf`, we use the variables we specified earlier to 
```HCL
locals {
  ami_id = "${var.ami_id}"
  vpc_id = "${var.vpc_id}"
  ssh_user = "ubuntu"
  key_name = "${var.aws_terraform_keyname}"
  private_key_path = "${var.aws_terraform_keyname}.pem"
}
```

### 2. Security Groups

Both provisioning and deployment servers require a security group. Since both require ports `22`, `80`, `8080`, we can use the same security group for both.

```HCL
resource "aws_security_group" "server_sec_group" {
	name   = "server_sec_group"
	vpc_id = local.vpc_id

  ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 8080
		to_port     = 8080
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
```
### 3. IAM role

```HCL
#Create an IAM Policy
resource "aws_iam_policy" "access-s3-policy" {
  name        = "S3accesspolicy"
  description = "Provides permission to access S3"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
})
}
```

```HCL
resource "aws_iam_role" "access_bucket_role" {
  name = "bucket_access_role"

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

}
```
## 2. S3 bucket
## 3. Provisioning and Deployment Servers
### 1. Inventory file in Ansible Provisioning Directory
### 2. Zipping Ansible Provisioning Directory
### 3. Upload to S3 bucket
### 4. Ansible Provisioning Directory Download to Provisioning Server
## 4. Ansible Provisioning
## 5. SSH Keys
## 6. Running Ansible Playbooks

# Ansible:
## 1. Tomcat Setup on Deployment Server
## 2. Clone and Build Hello World WAR File
## 3. Deploy WAR File and Restart Tomcat on Deployment Server

# Jenkins: 
## 1. Manual Setup of Pipeline
## 2. Testing and Validating Pipeline

